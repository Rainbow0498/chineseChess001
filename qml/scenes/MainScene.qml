//Author:tangyu
//Date:2023.6.12
//Function:mainWindow

import QtQuick 2.0
import QtQuick.Layouts 1.2
import Felgo 3.0
import"../common"
import "../dialogs"

SceneBase {
    id: mainScene
    signal beginGamePressed
//    signal closeGamePressed
    signal setGamePressed
    signal helpGamePressed

    //    Rectangle {
    //        id:mainWindow
    //        anchors.fill: parent.gameWindowAnchorItem

    BackgroundImage{
        id:backgroundImage
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/background/background-image.png"
        fillMode: Image.PreserveAspectCrop

    }

    //two functionButton
    MenuButton{
        id:beginButton
        width:70
        height: 30
        x:200
        y:250
        text:"Play"
        size:20
        bold:true
        buttonImage.source: "../../assets/background/bottonBackground.png"
        tap.onTapped: beginGamePressed()
        tap.onPressedChanged: {
            if(tap.pressed){
                beginButton.opacity = 0.5
                buttonImage.source = "../../assets/background/buttonBackground2.png"
            }else{
                beginButton.opacity = 1
                buttonImage.source = "../../assets/background/bottonBackground.png"
            }
        }
    }

    MenuButton{
        id:closeButton
        width:70
        height: 30
        x:200
        y:300
        text:"Exit"
        size:20
        bold:true
        buttonImage.source: "../../assets/background/bottonBackground.png"
        tap.onTapped: closeGamePressed()
        tap.onPressedChanged: {
            if(tap.pressed){
                closeButton.opacity = 0.5
                buttonImage.source = "../../assets/background/buttonBackground2.png"
            }else{
                closeButton.opacity = 1
                buttonImage.source = "../../assets/background/bottonBackground.png"
            }
        }
    }

    MenuButton{
        id:setButton
        width:70
        height: 30
        x:200
        y:350
        text:"Set"
        size:20
        bold:true
        buttonImage.source: "../../assets/background/bottonBackground.png"
        tap.onTapped: setGamePressed()
        tap.onPressedChanged: {
            if(tap.pressed){
                setButton.opacity = 0.5
                buttonImage.source = "../../assets/background/buttonBackground2.png"
            }else{
                setButton.opacity = 1
                buttonImage.source = "../../assets/background/bottonBackground.png"
            }
        }
    }

    MenuButton{
        id:helpButton
        width:70
        height: 30
        x:200
        y:400
        text:"Help"
        size:20
        bold:true
        buttonImage.source: "../../assets/background/bottonBackground.png"
        tap.onTapped: helpGamePressed()
        tap.onPressedChanged: {
            if(tap.pressed){
                helpButton.opacity = 0.5
                buttonImage.source = "../../assets/background/buttonBackground2.png"
            }else{
                helpButton.opacity = 1
                buttonImage.source = "../../assets/background/bottonBackground.png"
            }
        }
    }
    ExitPrompt{
        anchors.centerIn: parent
        id:exit
        visible: false
    }

    function closeGamePressed()
    {
        exit.visible = true
    }

}

