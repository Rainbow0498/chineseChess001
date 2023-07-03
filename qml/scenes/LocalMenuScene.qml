//Author:tangyu
//Date:2023.7.3
//Function:network scene

import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: localmenuScene
    //choose playMode
    signal createRoom
    signal joinRoom

    // background
    Rectangle {
        border.color: "red"
        anchors.fill: parent.gameWindowAnchorItem
        Image{
            id:localmenuBackgroundImage
            source: "../../assets/background/background-image2.png"
            fillMode:Image.PreserveAspectCrop
            anchors.fill: parent
        }
    }

    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 60
        font.pixelSize: 30
        color: "brown"
        font.bold: true
        font.family: standardFont.name
        text: "Network play" //zhucaidan
    }

    // TODO replace the buttons with your custom styled buttons
    Column {
        anchors.centerIn: parent
        spacing: 20
        MenuButton{
            id:createButton
            width:120
            height: 30
            text:"CreateRoom"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: createRoom()
            tap.onPressedChanged: {
                if(tap.pressed){
                    createButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    createButton.opacity = 1
                    buttonImage.source = "../../assets/background/bottonBackground.png"
                }
            }
        }

        MenuButton{
            id:joinButton
            width:120
            height: 30
            text:"JoinRoom"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: joinRoom()
            tap.onPressedChanged: {
                if(tap.pressed){
                    joinButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    joinButton.opacity = 1
                    buttonImage.source = "../../assets/background/bottonBackground.png"
                }
            }
        }

        MenuButton{
            id:backButton
            width:120
            height: 30
            text:"Back"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: backButtonPressed()
            tap.onPressedChanged: {
                if(tap.pressed){
                    backButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    backButton.opacity = 1
                    buttonImage.source = "../../assets/background/bottonBackground.png"
                }
            }
        }
    }
    //change the menu background image
    function changeMenuImage(str){
        localmenuBackgroundImage.source = str;
   }
}
