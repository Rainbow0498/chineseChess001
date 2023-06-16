//Author:tangyu
//Date:2023.6.13
//Function:menuWindow

import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase {
    id: menuScene
    //choose playMode
    signal levelPressed(string selectedLevel)

    // background
    Rectangle {
        border.color: "red"
        anchors.fill: parent.gameWindowAnchorItem
        Image{
            source: "../../assets/background/background-image2.png"
            fillMode: Image.PreserveAspectCrop
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
            width:70
            height: 30
            Image{
                id:singleButton_image
                source: "../../assets/background/bottonBackground.png"
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                MouseArea{
                    anchors.fill:parent
                    onEntered:{
                        singleButton_image.source = "../../assets/background/buttonBackground2.png"
                        singleText.color="#7B0E01"
                    }
                    onExited: {
                        singleButton_image.source ="../../assets/background/bottonBackground.png"
                        singleText.color="black"
                    }

                    onClicked: levelPressed("PlayOwnScene.qml")

                    onPressed: {
                        singleButton.opacity =0.5
                    }
                    onReleased: {
                        singleButton.opacity =1
                    }
                }
                Text {
                    id: singleText
                    text: qsTr("SingleFight")
                    font.bold: true
                    font.pixelSize: 12
                    font.family: standardFont.name
                    anchors.centerIn: parent
                }
            }
        }

        MenuButton{
            id:doubleButton
            width:70
            height: 30
            Image{
                id:doubleButton_image
                source: "../../assets/background/bottonBackground.png"
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                MouseArea{
                    anchors.fill:parent
                    onEntered:{
                        doubleButton_image.source = "../../assets/background/buttonBackground2.png"
                        doubleText.color="#7B0E01"
                    }
                    onExited: {
                        doubleButton_image.source ="../../assets/background/bottonBackground.png"
                        doubleText.color="black"
                    }
                    onClicked: levelPressed("PlayDoubleScene.qml")
                    onPressed: {
                        doubleButton.opacity =0.5
                    }
                    onReleased: {
                        doubleButton.opacity =1
                    }
                }
                Text {
                    id: doubleText
                    text: qsTr("DoubleFight")
                    font.bold: true
                    font.pixelSize: 12
                    font.family: standardFont.name
                    anchors.centerIn: parent
                }
            }
        }

        MenuButton{
            id:aiButton
            width:70
            height: 30
            Image{
                id:aiButton_image
                source: "../../assets/background/bottonBackground.png"
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                MouseArea{
                    anchors.fill:parent
                    onEntered:{
                        aiButton_image.source = "../../assets/background/buttonBackground2.png"
                        aiText.color="#7B0E01"
                    }
                    onExited: {
                        aiButton_image.source ="../../assets/background/bottonBackground.png"
                        aiText.color="black"
                    }
                    onClicked: levelPressed("PlayAiScene.qml")
                    onPressed: {
                        aiButton.opacity =0.5
                    }
                    onReleased: {
                        aiButton.opacity =1
                    }
                }
                Text {
                    id: aiText
                    text: qsTr("DoubleFight")
                    font.bold: true
                    font.pixelSize: 12
                    font.family: standardFont.name
                    anchors.centerIn: parent
                }
            }
        }

        MenuButton{
            id:backButton
            width:70
            height: 30
            Image{
                id:backButton_image
                source: "../../assets/background/bottonBackground.png"
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                MouseArea{
                    anchors.fill:parent
                    onEntered:{
                        backButton_image.source = "../../assets/background/buttonBackground2.png"
                        backText.color="#7B0E01"
                    }
                    onExited: {
                        backButton_image.source ="../../assets/background/bottonBackground.png"
                        backText.color="black"
                    }
                    onClicked: backButtonPressed()
                    onPressed: {
                        backButton.opacity =0.5
                    }
                    onReleased: {
                        backButton.opacity =1
                    }
                }
                Text {
                    id: backText
                    text: qsTr("Back")
                    font.bold: true
                    font.pixelSize: 12
                    font.family: standardFont.name
                    anchors.centerIn: parent
                }
            }
        }
    }
}
