//Author:daixin
//Date:2023.6.21
//Function:realize communication connection

#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QHostAddress>
#include <QtNetwork>

class Client : public QObject
{
    Q_OBJECT
   public:

       explicit Client(QObject *parent = nullptr);
       Q_INVOKABLE void cheesChangedSlot(int x,int y,int x1,int y1);
       Q_INVOKABLE void disConnect();

       Q_PROPERTY(int lastrow READ getLastrow WRITE setLastrow NOTIFY lastrowChanged)
       Q_PROPERTY(int lastcol READ getLastcol WRITE setLastcol NOTIFY lastcolChanged)
       Q_PROPERTY(int row READ getRow WRITE setRow NOTIFY rowChanged)
       Q_PROPERTY(int col READ getCol WRITE setCol NOTIFY colChanged)

       int getLastrow() const;
       void setLastrow(int newLastrow);

       int getLastcol() const;
       void setLastcol(int newLastcol);

       int getRow() const;
       void setRow(int newRow);

       int getCol() const;
       void setCol(int newCol);

   public slots:

       void portSlot(QString p,QString i);
       void displayError(QAbstractSocket::SocketError);

   signals:
       void connectSuccess();
       void receiveOk();
       void lastrowChanged();
       void lastcolChanged();
       void rowChanged();
       void colChanged();
       void writeOk();
       void disConnectSignal();

   private:
       quint16 port;
       QString ip;
       QTcpSocket *_socket;
       int lastrow;
       int lastcol;
       int row;
       int col;
};

#endif // CLIENT_H


