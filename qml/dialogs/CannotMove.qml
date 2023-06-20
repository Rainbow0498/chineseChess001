//Author:yangyunbo
//Date:2023.6.17
//Function:cannot move the chess and show this item

import QtQuick 2.0
import QtQuick.Controls 2.15
import "../common"

// leaveGame window when trying to exit the game
Item {
    id: cannotMove
    width: 400
    height: cMRectText.height + cMRectText.anchors.topMargin * 2
    z: 110
    visible: false

    // dark background
    Rectangle {
        anchors.centerIn: parent
        width: playScene.width * 2
        height: playScene.height * 2
        color: "black"
        opacity: 0.3

        // catch the mouse clicks
        MouseArea {
            anchors.fill: parent
        }
    }

    // message background
    Rectangle {
        id: cMRect
        radius: 30
        anchors.fill: parent
        color: "#FFFFFF"
        border.color: "gray"
        border.width: 5
    }


    // CannotMove text
    Text {
        id: cMRectText
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: cMRect.horizontalCenter
        anchors.top: cMRect.top
        anchors.margins: 40
        text: "This is not your round!!"
        font.family: standardFont.name
        color: "black"
        font.pixelSize: 36
        width: cMRect.width * 0.8//- anchors.topMargin * 2
        wrapMode: Text.Wrap
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
        onClicked: {
            cannotMove.visible = false
        }
    }
}
