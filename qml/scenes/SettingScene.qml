//Author:daixin
//Date:2023.6.14
//Function:setWindow
// Realize the music play and backgroung change

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2
import Felgo 3.0
import "../common"
SceneBase{

    id:settingScene

    Rectangle {
        id:mainWindow
        anchors.fill: parent.gameWindowAnchorItem

        BackgroundImage{
            id:settingbackGround
            source: "../../assets/background/checkerboard-back2.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }
    }

    MenuButton{
        id:backButton
        width:70
        height: 30
        anchors.left:parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: 20
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
                font.pixelSize: 20
                font.family: standardFont.name
                anchors.centerIn: parent
            }
        }

    }

    Text {
        id: settingText
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Set")
        font.bold: true
        font.family: standardFont.name
        font.pixelSize: 48
    }

    Column{
        id:settingColumn
        anchors.centerIn: parent
        anchors.topMargin: 100
        //control the background music playing
        RowLayout{
            Text{
                text: "Sound Switch"
            }

            //Click the button to control the background music playing
            Switch{
                id:soundSwitch
                Layout.fillWidth: true
                text: "ON"
                checked: true
                onCheckedChanged: {
                    soundSwitch.text = soundSwitch.checked ? "ON" : "OFF"
                }

                onClicked:{
                    if(soundSwitch.text == "OFF"){
                        musicPlayer.pause();
                    }else{
                        musicPlayer.play();
                    }
                }
            }
        }

        ComboBox{
            id:backgroundComboBox
            width: settingColumn.width
            height: 50
            model:["background1","background2","background3","background4"]
            currentIndex: 0

            // Click the button to switch the background of the help page and the menu page
            onCurrentIndexChanged: {

                if(currentIndex == 0){
                    menuScene.changeMenuImage("../../assets/background/background-image2.png");
                    helpScene.changeHelpImage("../../assets/background/background-image2.png");
                }else if(currentIndex == 1){
                    menuScene.changeMenuImage("../../assets/background/background-image.png");
                    helpScene.changeHelpImage("../../assets/background/background-image.png");
                }else if(currentIndex == 2){
                    menuScene.changeMenuImage("../../assets/background/checkerboard-back2.png");
                    helpScene.changeHelpImage("../../assets/background/checkerboard-back2.png");
                }else{
                    menuScene.changeMenuImage("../../assets/background/checkerboard-back3.png");
                    helpScene.changeHelpImage("../../assets/background/checkerboard-back3.png");

                }
            }
        }

    }

}
