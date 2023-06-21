//Author:yangyunbo
//Date:2023.6.17
//Function:make the play rules
import QtQuick 2.0
import QtQuick.Controls 2.15
import "../common"

// leaveGame window when trying to exit the game
Item {
    id: chooseRules
    width: 400
    height: content.height + content.anchors.topMargin * 2
    z: 110


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
        id: chooseRect
        radius: 30
        anchors.fill: parent
        color: "#FFFFFF"
        border.color: "gray"
        border.width: 5
    }

    Column {
        id: content
        width: chooseRect.width
        anchors.horizontalCenter: chooseRect.horizontalCenter
        anchors.top: chooseRect.top
        anchors.margins: 40
        spacing: 20
        // chooseRules text
        Text {
            id: chooseTextTitle
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Please choose the game rules:"
            font.family: standardFont.name
            color: "black"
            font.pixelSize: 36
            width: parent.width * 0.8//- anchors.topMargin * 2
            wrapMode: Text.Wrap
        }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:10
                Text{
                    id:stepTime
                    text:"step Time: "
                    horizontalAlignment: Text.AlignHCenter
                }
                ComboBox{
                    id:minuteStep
                    model:["1min","2min","3min","4min","5min"]
                }
                ComboBox{
                    id:secondStep
                    model:["0second","15second","30second","45second"]
                }

            }
        }

        // button to leave the game
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
            text: "Start Play"
            tap.onTapped: {
                player1.minute = parseInt(minuteStep.currentText)
                player1.second = parseInt(secondStep.currentText)
                player2.minute = parseInt(minuteStep.currentText)
                player2.second = parseInt(secondStep.currentText)
                gameLogic.initGame()

                chooseRules.visible = false
            }
        }
    }
