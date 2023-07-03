//Author:daixin
//Date:2023.6.21
//Function:realize communication connection

#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}
{
    _socket = new QTcpSocket(this);

    connect(_socket, &QTcpSocket::connected, this, [=](){
        emit connectSuccess();
    });
    //当有数据发送过来时，执行槽函数
    connect(_socket,&QTcpSocket::readyRead,this,[=](){
        QByteArray data = _socket->readAll();  //读取服务端发送过来的数据

        QStringList list = QString(data).split(",");
        lastrow = 10-list[0].toInt()+1;
        lastcol = 9-list[1].toInt()+1;
        row = 10-list[2].toInt()+1;
        col = 9-list[3].toInt()+1;
        qDebug()<<list<<"  "<<lastrow<<"  "<<lastcol<<"  "<<row<<"  "<<col;
        emit receiveOk(); //将数据发送到QML端进行使用
    });

    connect(_socket,&QTcpSocket::disconnected,this,[=](){
        emit disConnectSignal();
        _socket->close();
        _socket->deleteLater();
    });

}

void Client::portSlot(QString p,QString i)
{
    port = p.toUShort();
    ip=i;
    if(port == 0){
        qDebug()<<"port error!";
    }
    qDebug()<< __FUNCTION__ << "  " << port << "  " << ip;

    QStringList list = ip.split(".");

    if(list.size()!=4){
        qDebug()<< "ip error";
        return;
    }

    for(int i=0;i<4;i++){
        if(list[i].size()==0){
            qDebug()<<"ip error";
            return;
        }
        if(list[i].size()>3){
            qDebug()<<"ip error";
            return;
        }
        for(int j=0;j<list[i].size();j++){
            if(list[i].at(j)<'0'&&list[i].at(j)>'9'){
                qDebug()<<"ip error";
                return;
            }
        }
    }
    _socket->connectToHost(ip,port);
}

void Client::displayError(QAbstractSocket::SocketError)
{
    qDebug()<<_socket->errorString();
}

int Client::getCol() const
{
    return col;
}

void Client::setCol(int newCol)
{
    if (col == newCol)
        return;
    col = newCol;
    emit colChanged();
}

int Client::getRow() const
{
    return row;
}

void Client::setRow(int newRow)
{
    if (row == newRow)
        return;
    row = newRow;
    emit rowChanged();
}

int Client::getLastcol() const
{
    return lastcol;
}

void Client::setLastcol(int newLastcol)
{
    if (lastcol == newLastcol)
        return;
    lastcol = newLastcol;
    emit lastcolChanged();
}

int Client::getLastrow() const
{
    return lastrow;
}

void Client::setLastrow(int newLastrow)
{
    if (lastrow == newLastrow)
        return;
    lastrow = newLastrow;
    emit lastrowChanged();
}

void Client::cheesChangedSlot(int x, int y, int x1, int y1)
{
    QString mes;
    mes = QString::number(x) + "," + QString::number(y)
            + "," + QString::number(x1) + "," + QString::number(y1);
    qDebug()<<"11111";
    _socket->write(mes.toUtf8());
    emit writeOk();
}

void Client::disConnect()
{
    _socket->disconnectFromHost();
    _socket->close();
    _socket->deleteLater();
}
