//Author:tangyu
//Date:2023.6.13
//Function:helpWindow

import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15
import Felgo 3.0
import "../common"

SceneBase{
    id:helpscene
    property int currentPage: 0 // page indicator
    Rectangle {
        id:mainWindow
        anchors.fill: parent.gameWindowAnchorItem
        anchors.centerIn: parent

        //set backgroundImage
        BackgroundImage{
            id:helpBackgroungImage
            source: "../../assets/background/checkerboard-back2.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }

        //main Content
        Rectangle{
            color: "transparent"
            anchors.fill: parent
            MenuButton{
                id:backButton
                width:70
                height: 30
                anchors.left:parent.left
                anchors.top: parent.top
                anchors.leftMargin: 20
                anchors.topMargin: 20
                text:"Back"
                size:20
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
            //a rowLayout contains two buttons and a text
            RowLayout {
                id:rowLayout
                y:90
                anchors.horizontalCenter: parent.horizontalCenter
                MenuButton{
                    id: prevPageButton
                    width:60
                    height: 30
                    enabled: helpscene.currentPage > 0 // disable when on first page
                    text:"<"
                    size:20
                    bold:true
                    buttonImage.source: "../../assets/background/bottonBackground.png"
                    tap.onTapped: helpscene.currentPage--
                    tap.onPressedChanged: {
                        if(tap.pressed){
                            prevPageButton.opacity = 0.5
                            buttonImage.source = "../../assets/background/buttonBackground2.png"
                        }else{
                            prevPageButton.opacity = 1
                            buttonImage.source = "../../assets/background/bottonBackground.png"
                        }
                    }
                }

                //center text
                Text {
                    id: helpText
                    text: (helpscene.currentPage===0)?qsTr("About Game"):qsTr("About Chess")
                    font.bold: true
                    font.family: standardFont.name
                    font.pixelSize: 32
                }

                MenuButton{
                    id: nextPageButton
                    width:60
                    height: 30
                    enabled: helpscene.currentPage < 1
                    text:">"
                    size:20
                    bold:true
                    buttonImage.source: "../../assets/background/bottonBackground.png"
                    tap.onTapped: helpscene.currentPage++
                    tap.onPressedChanged: {
                        if(tap.pressed){
                            nextPageButton.opacity = 0.5
                            buttonImage.source = "../../assets/background/buttonBackground2.png"
                        }else{
                            nextPageButton.opacity = 1
                            buttonImage.source = "../../assets/background/bottonBackground.png"
                        }
                    }
                }
            }
            ScrollView{
                anchors.centerIn: parent
                width:200
                height:200
                Layout.fillHeight: true
                Layout.fillWidth: true
                TextArea {
                    id: helpContent1
                    visible: helpscene.currentPage === 0 // Visible when currentPage is 0
                    //width: parent.width
                    text: qsTr("This is a ChineseChess Game.You can play the game with your friend...
                                        you can also choose to play yourself or play with AI,we really hope you can enjoy our game")
                    font.family: "NSimSun"
                    font.bold: true
                    font.pixelSize: 20
                    clip: true
                    wrapMode: Text.Wrap
                }
                TextArea {
                    id: helpContent2
                    visible: helpscene.currentPage === 1 // Visible when currentPage is 1
                    // width: parent.width
                    text: qsTr("ChineseChess is a traditional Chinese chess game...")
                    font.family: "NSimSun"
                    font.bold: true
                    font.pixelSize: 20
                    clip: true
                    wrapMode: Text.Wrap
                }
            }
            ScrollBar{
                Layout.fillWidth: true
            }
        }
    }

    //change the help background image
    function changeHelpImage(str){
        helpBackgroungImage.source = str;
   }

}
