//Author:yangyunbo
//Date:2023.7.3
//Function: create client
import QtQuick 2.15
import Felgo 3.0
import "../common"
import Client 1.0
import QtQuick.Controls 1.4
// CREATEROOM SCENE

SceneBase {

    // signal indicating that the gameScene should be displayed
    signal sendMes
    signal gamePressed
    signal connectSig(var p,var i)
    signal disConnect_Client

    property int row1
    property int col1
    property int row2
    property int col2

    id: joinRoomScene
    anchors.fill: parent

    BackgroundImage{
        id:backgroundImage
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/background/background-image2.png"
        fillMode: Image.PreserveAspectCrop
    }
    Text {
        id:title
        anchors.horizontalCenter: parent.horizontalCenter
        y: joinRoomScene.height/9
        font.pixelSize: 30
        color: "brown"
        font.bold: true
        font.family: standardFont.name
        text: "Join Room"
    }

    Item{
        id:body
        anchors.horizontalCenter: parent.horizontalCenter
        y:title.y+150
        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:30
            Row{
                spacing: 10
                Column{
                    spacing:20
                    Text {
                        font.pixelSize: 30
                        text: qsTr("IP:")
                    }
                    Text {
                        font.pixelSize: 30
                        text: qsTr("Port:")
                    }
                }

                Column{
                    spacing:20
                    TextField{
                        id: ip
                        width: 210
                        height: 40
                        textColor: "black"
                    }

                    TextField{
                        id: port
                        width: 210
                        height: 40
                        textColor: "black"
                    }
                }
            }
            ButtonBase{
                id:join
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Join"
                textSize: 30
                width:parent.width
                textColor: "black"
                tap.onTapped : {
                    connectSig(port.getText(0,6),ip.getText(0,15))
                }
            }

            Component.onCompleted: {
                connectSig.connect(client.portSlot)
            }


            ButtonBase{
                id:backButton
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width
                textSize:30
                text:"Back"
                tap.onTapped: backButtonPressed()
            }
        }
    }


    Client{
        id:client
        onConnectSuccess: {
            gamePressed()
            playDoubleScene.camp = 0
//            playScene.visible = true
        }
        onReceiveOk: {
            console.log("4")
            row1=client.lastrow
            col1=client.lastcol
            row2=client.row
            col2=client.col
            console.log(row1,col1,row2,col2)
            playDoubleScene.move_connect()
        }
        onWriteOk: {
            console.log("33")
            console.log("R write ok")
        }
    }

    onSendMes:{
        console.log("22")
        console.log(row1,col1,row2,col2)

        client.cheesChangedSlot(row1,col1,row2,col2)
    }

    onDisConnect_Client: {
        client.disConnect()
    }
}

