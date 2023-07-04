//Author:yangyunbo
//Date:2023.7.4
//Function:gameOver window

import QtQuick 2.0
import QtQuick.Controls 2.15
import "../common"

// gameOver window when trying to exit the game
Item {
    id: gameOver
    width: 400
    height: content.height + content.anchors.topMargin * 2
    z: 110
    visible: false
    property bool winner

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


    // gameOver text
    Column {
        id: content
        width: lpRect.width
        anchors.horizontalCenter: lpRect.horizontalCenter
        anchors.top: lpRect.top
        anchors.margins: 40
        spacing: 20

        Text{
            text: winner?"Red win":"Black win"
            font.bold: true
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // chooseRules text
        ButtonBase{
            id: playAgain
            text:"再来一把"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                gameOver.visible = false
                gameLogic.initGame()
            }
        }
        ButtonBase{
            id:backMenu
            text:"返回目录"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                gameOver.visible = false
                gameWindow.state = "menu"
            }
        }
        ButtonBase{
            id:backMain
            text:"返回主页面"
            anchors.horizontalCenter: parent.horizontalCenter
            tap.onTapped: {
                gameOver.visible = false
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
            gameOver.visible = false
        }
    }
}
