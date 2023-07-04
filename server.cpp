//Author:daixin
//Date:2023.6.21
//Function:realize communication connection

#include "server.h"

Server::Server(QObject *parent)
    : QObject{parent}
{
    //get self ip
    QString localHostName = QHostInfo::localHostName();
    QHostInfo info = QHostInfo::fromName(localHostName);

    foreach(QHostAddress address,info.addresses()){
        if(address.protocol() == QAbstractSocket::IPv4Protocol){
            this->ip=address.toString();
        }
    }
    qDebug()<<this->ip;
}

const QString &Server::getIp() const
{
    return ip;
}

void Server::setIp(const QString &newIp)
{
    if (ip == newIp)
        return;
    ip = newIp;
    emit ipChanged();
}

void Server::portSlot(QString s)
{
    port = s.toUShort();
    if(port == 0){
        qDebug()<<"port error!";
    }
    qDebug()<<__FUNCTION__<<"  "<<port;

    _server = new QTcpServer(this);
    if(!_server->listen(QHostAddress::Any,port)){
        qDebug()<<_server->errorString();
        return;
    }

    //有新的连接后，执行newConnect槽函数
    connect(_server,&QTcpServer::newConnection,this,[=](){
        emit connectSuccess();

        _socket=_server->nextPendingConnection();

         //当检测到有新数据传输过来时，执行槽函数
        connect(_socket,&QTcpSocket::readyRead,this,[=](){
            QByteArray data = _socket->readAll();
            QStringList list = QString(data).split(",");
            lastrow = list[0].toInt();
            lastcol =list[1].toInt();
            row = list[2].toInt();
            col =list[3].toInt();
            qDebug()<<list<<"  "<<lastrow<<"  "<<lastcol<<"  "<<row<<"  "<<col;
            emit receiveOk();
        });

        connect(_socket,&QTcpSocket::disconnected,this,[=](){
            emit disConnectSignal();
            _socket->close();
            _socket->deleteLater();
        });
        qDebug()<<"server start";
    });
}

int Server::getCol() const
{
    return col;
}

void Server::setCol(int newCol)
{
    if (col == newCol)
        return;
    col = newCol;
    emit colChanged();
}

int Server::getRow() const
{
    return row;
}

void Server::setRow(int newRow)
{
    if (row == newRow)
        return;
    row = newRow;
    emit rowChanged();
}

int Server::getLastcol() const
{
    return lastcol;
}

void Server::setLastcol(int newLastcol)
{
    if (lastcol == newLastcol)
        return;
    lastcol = newLastcol;
    emit lastcolChanged();
}

int Server::getLastrow() const
{
    return lastrow;
}

void Server::setLastrow(int newLastrow)
{
    if (lastrow == newLastrow)
        return;
    lastrow = newLastrow;
    emit lastrowChanged();
}

void Server::cheesChangedSlot(int x,int y,int x1,int y1)
{
    QString mes;
    mes = QString::number(x)+","+QString::number(y)+","
            +QString::number(x1)+","+QString::number(y1);
    qDebug()<< "11111  " << mes;
    _socket->write(mes.toUtf8());
    emit writeOk();
}

void Server::disConnect()
{
    _socket->disconnectFromHost();
    _socket->close();
    _socket->deleteLater();
}
