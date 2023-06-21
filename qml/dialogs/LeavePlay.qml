//Author:yangyunbo
//Date:2023.6.20
//Function:cannot move the chess and show this item

import QtQuick 2.0
import QtQuick.Controls 2.15
import "../common"

// leaveGame window when trying to exit the game
Item {
    id: leavePlay
    width: 400
    height: content.height + content.anchors.topMargin * 2
    z: 110
    visible: false

    // dark background
    Rectangle {
        anchors.centerIn: parent
        width: playScene.width * 2
        height: playScene.height * 2
        color: "black"
        opacity: 0.3
    }

    // message background
    Rectangle {
        id: lpRect
        radius: 30
        anchors.fill: parent
        color: "#FFFFFF"
        border.color: "gray"
        border.width: 5
    }


    // leavePlay text
    Column {
        id: content
        width: lpRect.width
        anchors.horizontalCenter: lpRect.horizontalCenter
        anchors.top: lpRect.top
        anchors.margins: 40
        spacing: 20
        // chooseRules text
        ButtonBase{
            id: playAgain
            text:"继续游戏"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                leavePlay.visible = false
            }
        }
        ButtonBase{
            id:restartPlay
            text:"重新开始"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                gameLogic.initGame()
                leavePlay.visible = false
            }
        }
        ButtonBase{
            id:backMenu
            text:"返回目录"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                leavePlay.visible = false
                gameWindow.state = "menu"
            }
        }
        ButtonBase{
            id:backMain
            text:"返回主页面"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                leavePlay.visible = false
                gameWindow.state = "main"
            }
        }
    }

    // button to leave the item
    ButtonBase {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: 10
        width: parent.width / 2 - anchors.topMargin / 2
        height: (20 + buttonText.height + paddingVertical * 2)
        paddingHorizontal: 8
        paddingVertical: 4
        box.border.width: 5
        box.radius: 30
        textSize: 28
        text: "OK"

        tap.onTapped: {
            leavePlay.visible = false
        }
    }
}
