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
        Image{
            id: beginButton_image
            source: "../../assets/background/bottonBackground.png"

            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onEntered:{
                    beginButton_image.source = "../../assets/background/buttonBackground2.png"
                    beginText.color="#7B0E01"
                }
                onExited: {
                    beginButton_image.source ="../../assets/background/bottonBackground.png"
                    beginText.color="black"
                }

                onClicked: beginGamePressed()

                onPressed: {
                    beginButton.opacity =0.5
                }
                onReleased: {
                    beginButton.opacity =1
                }
            }
            Text {
                id: beginText
                text: qsTr("Play")
                font.bold: true
                font.pixelSize: 20
                font.family: standardFont.name
                anchors.centerIn: parent
            }
        }

    }

    MenuButton{
        id:closeButton
        width:70
        height: 30
        x:200
        y:300
        Image{
            id:closeButton_image
            source: "../../assets/background/bottonBackground.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onEntered:{
                    closeButton_image.source = "../../assets/background/buttonBackground2.png"
                    closeText.color="#7B0E01"

                }
                onExited: {
                    closeButton_image.source ="../../assets/background/bottonBackground.png"
                    closeText.color="black"
                }
                onClicked: closeGamePressed()
                onPressed: {
                    closeButton.opacity =0.5
                }
                onReleased: {
                    closeButton.opacity =1
                }
            }
            Text {
                id: closeText
                text: qsTr("Exit")
                font.bold: true
                font.pixelSize: 20
                font.family:standardFont.name
                anchors.centerIn: parent
            }
        }

    }

    MenuButton{
        id:setButton
        width:70
        height: 30
        x:200
        y:350
        Image{
            id:setButton_image
            source: "../../assets/background/bottonBackground.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onEntered:{
                    setButton_image.source = "../../assets/background/buttonBackground2.png"
                    setText.color="#7B0E01"
                }
                onExited: {
                    setButton_image.source ="../../assets/background/bottonBackground.png"
                    setText.color="black"
                }
                onClicked: setGamePressed()
                onPressed: {
                    setButton.opacity =0.5
                }
                onReleased: {
                    setButton.opacity =1
                }
            }
            Text {
                id: setText
                text: qsTr("Set")
                font.bold: true
                font.pixelSize: 20
                font.family: standardFont.name
                anchors.centerIn: parent
            }
        }

    }

    MenuButton{
        id:helpButton
        width:70
        height: 30
        x:200
        y:400
        Image{
            id: helpButton_image
            source: "../../assets/background/bottonBackground.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            MouseArea{
                anchors.fill:parent
                onEntered:{
                    helpButton_image.source = "../../assets/background/buttonBackground2.png"
                    helpText.color="#7B0E01"
                }
                onExited: {
                    helpButton_image.source ="../../assets/background/bottonBackground.png"
                    helpText.color="black"
                }
                onClicked: helpGamePressed()
                onPressed: {
                    helpButton.opacity =0.5
                }
                onReleased: {
                    helpButton.opacity =1
                }
            }
            Text {
                id: helpText
                text: qsTr("Help")
                font.bold: true
                font.pixelSize: 20
                font.family: standardFont.name
                anchors.centerIn: parent
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

