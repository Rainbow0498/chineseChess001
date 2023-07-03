//Author:daixin
//Date:2023.6.21
//Function:realize communication connection

#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QtNetwork>

class Server : public QObject
{
    Q_OBJECT
public:
    explicit Server(QObject *parent = nullptr);
    Q_PROPERTY(QString ip READ getIp WRITE setIp NOTIFY ipChanged)
    Q_PROPERTY(int lastrow READ getLastrow WRITE setLastrow NOTIFY lastrowChanged)
    Q_PROPERTY(int lastcol READ getLastcol WRITE setLastcol NOTIFY lastcolChanged)
    Q_PROPERTY(int row READ getRow WRITE setRow NOTIFY rowChanged)
    Q_PROPERTY(int col READ getCol WRITE setCol NOTIFY colChanged)

    const QString &getIp() const;
    void setIp(const QString &newIp);
    Q_INVOKABLE void cheesChangedSlot(int x,int y,int x1,int y1);
    Q_INVOKABLE void disConnect();

    int getLastrow() const;
    void setLastrow(int newLastrow);

    int getLastcol() const;
    void setLastcol(int newLastcol);

    int getRow() const;
    void setRow(int newRow);

    int getCol() const;
    void setCol(int newCol);

public slots:
    void portSlot(QString s);

signals:
    void ipChanged();
    void connectSuccess();
    void lastrowChanged();
    void lastcolChanged();
    void writeOk();
    void receiveOk();
    void rowChanged();
    void colChanged();
    void disConnectSignal();

private:
    QString ip;
    quint16 port;
    QTcpServer *_server;
    QTcpSocket *_socket;
    int lastrow;
    int lastcol;
    int row;
    int col;
};

#endif // SERVER_H
