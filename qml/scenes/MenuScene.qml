//Author:tangyu
//Date:2023.6.13
//Function:menuWindow

import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: menuScene
    //choose playMode
    signal beginOwnPlay
    signal beginAIPlay
    signal beginDoublePlay
    signal levelPressed(string selectedLevel)

    // background
    Rectangle {
        border.color: "red"
        anchors.fill: parent.gameWindowAnchorItem
        Image{
            id:menuBackgroundImage
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
        text: "Menu Scene" //zhucaidan
    }

    // TODO replace the buttons with your custom styled buttons
    Column {
        anchors.centerIn: parent
        spacing: 20
        MenuButton{
            id:singleButton
            width:120
            height: 30
            text:"SingleFight"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: beginOwnPlay()
            tap.onPressedChanged: {
                if(tap.pressed){
                    singleButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    singleButton.opacity = 1
                    buttonImage.source = "../../assets/background/bottonBackground.png"
                }
            }
        }

        MenuButton{
            id:doubleButton
            width:120
            height: 30
            text:"DoubleFight"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: beginDoublePlay()
            tap.onPressedChanged: {
                if(tap.pressed){
                    doubleButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    doubleButton.opacity = 1
                    buttonImage.source = "../../assets/background/bottonBackground.png"
                }
            }
        }

        MenuButton{
            id:aiButton
            width:120
            height: 30
            text:"AIFight"
            size:12
            bold:true
            buttonImage.source: "../../assets/background/bottonBackground.png"
            tap.onTapped: beginAIPlay()
            tap.onPressedChanged: {
                if(tap.pressed){
                    aiButton.opacity = 0.5
                    buttonImage.source = "../../assets/background/buttonBackground2.png"
                }else{
                    aiButton.opacity = 1
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
        menuBackgroundImage.source = str;
   }
}
