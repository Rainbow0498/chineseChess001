//Author: daixin
//Date:2023.6.14
//Function:notify whether quit the game

import QtQuick 2.0
import Felgo 3.0
import QtGraphicalEffects 1.13
import "../common"
import "../scenes"


// when you will exit this game...

Item {
    id:exitPrompt
    width:200
      height:content.height+content.anchors.topMargin*2
    //height:200
    z:110

    anchors.centerIn: parent

    //dark BackgroundImage
    Rectangle{
        anchors.centerIn: parent
        width:parent.width*6
        height:parent.height*6
        color: "black"
        opacity: 0.3
        radius: 30
        //catch mouse clicks
        MouseArea{
            anchors.fill: parent
        }
    }
    //exitprompt background
    Rectangle{
        id:exitRect
        radius: 30
        width:parent.width/2
        height:parent.height/2
        anchors.fill: parent
        color:"#FAEBD7"
    //    border.color: "lightblue"
    //    border.width: 5
        opacity: 0.9
//        BackgroundImage{
//         source: "../../assets/background/checkerboard-back2.png"
//         fillMode: Image.PreserveAspectCrop
//         anchors.fill: parent
//         opacity: 0.7
//         clip: true

//     }
    }


    Column{
        id:content
        width:parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        //        anchors.margins: 40
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        spacing: 20

        Text {
            id: titleText
                        horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Exit Prompt"
            color: "black"
            font.pixelSize: 30
            font.family: standardFont.name
            width: parent.width * 0.8
            wrapMode: Text.Wrap
     //       anchors.centerIn: parent
     //       anchors.top: parent.top
        }
        //exit text
        Text {
            id: promptText
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Are you sure quit the game?"
            color: "black"
            font.pixelSize: 24
            font.family: standardFont.name
            width: parent.width * 0.8
            wrapMode: Text.Wrap
            //        anchors.centerIn: parent
    //        anchors.bottom: parent.bottom
        }

    }
    // button to close the window
    MenuButton {
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.topMargin: 10
        width: parent.width / 2 - anchors.topMargin / 2
        height: (20 +parent.height/8+ paddingVertical * 2)
        paddingHorizontal: 8
        paddingVertical: 4
        text: "Cancel"
        onClicked: exitPrompt.visible = false
    }

    // button to leave the game
    MenuButton {
        anchors.left: parent.left
        anchors.top: parent.bottom
        anchors.topMargin: 10
        width: parent.width / 2 - anchors.topMargin / 2
        height:(20 +parent.height/8+ paddingVertical * 2)
        paddingHorizontal: 8
        paddingVertical: 4
        text: "Quit"
        onClicked: {
            gameWindow.visible=false  //close the game
            musicPlayer.pause();
        }
    }

}
