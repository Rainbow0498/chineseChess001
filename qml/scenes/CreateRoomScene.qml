//Author:yangyunbo
//Date:2023.7.3
//Function: create server
import QtQuick 2.15
import Felgo 3.0
import "../common"
import Server 1.0
import QtQuick.Controls 1.4
// CREATEROOM SCENE

SceneBase {

    // signal indicating that the gameScene should be displayed
    signal gamePressed

    signal sendMes
    signal portSig(var s)
    signal disConnect_Server

    property int row1
    property int col1
    property int row2
    property int col2


    id: createRoomScene
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
        y: createRoomScene.height/9
        font.pixelSize: 30
        color: "brown"
        font.bold: true
        font.family: standardFont.name
        text: "Create Room" //zhucaidan
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
                Text {
                    font.pixelSize: 30
                    text: qsTr("Port:")
                }
                TextField{
                    id: port
                    width: 210
                    height: 40
                    textColor: "black"
                }
            }

            Text {
                width:parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 25
                text: qsTr("本地IP: "+server.ip)
            }

            Rectangle{
                id:waitMessage
                visible: false
                width:parent.width
                height: 40
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: qsTr("waiting...")
                    font.pixelSize: 25
                }
            }

            ButtonBase{
                id:create
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Create"
                textSize: 30
                width:parent.width
                textColor: "black"
                tap.onTapped : {
                    portSig(port.getText(0,10))
                    waitMessage.visible = true
                }
            }

            Component.onCompleted: {
                portSig.connect(server.portSlot)
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

    Server{
        id:server

                onConnectSuccess: {
                    gamePressed()
                    gameLogic.camp = 0
                    playScene.visible = true
                    waitMessage.visible = false
                }

                onReceiveOk: {
                    console.log("44")
                    row1=server.lastrow
                    col1=server.lastcol
                    row2=server.row
                    col2=server.col
                    console.log(row1,col1,row2,col2)
                    gameScene.move_server()
                }

                onWriteOk: {
                    console.log("3")
                    console.log("C write ok")
                }
    }

    onSendMes:{
        console.log("2")
        console.log(row1,col1,row2,col2)
        server.cheesChangedSlot(row1,col1,row2,col2)
    }

    onDisConnect_Server: {
           server.disConnect()
       }
}

