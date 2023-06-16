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
                }
                Text {
                    id: backText
                    text: qsTr("Back")
                    padding: 10
                    font.bold: true
                    font.pixelSize: 20
                    font.family: standardFont.name
                    anchors.centerIn: parent
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
                    Image{
                        id:prevPageButton_Image
                        source: "../../assets/background/bottonBackground.png"
                        fillMode: Image.PreserveAspectCrop
                        anchors.fill: parent
                        MouseArea{
                            anchors.fill:parent
                            onEntered:{
                                prevPageButton_Image.source = "../../assets/background/buttonBackground2.png"
                                prevPageText.color="#7B0E01"
                            }
                            onExited: {
                                prevPageButton_Image.source ="../../assets/background/bottonBackground.png"
                                prevPageText.color="black"
                            }
                            onPressed: {
                                prevPageButton.opacity =0.5
                            }
                            onReleased: {
                                prevPageButton.opacity =1
                            }
                            onClicked: helpscene.currentPage--
                        }
                        Text {
                            id: prevPageText
                            text: qsTr("<")
                            font.bold: true
                            font.pixelSize: 20
                            font.family: standardFont.name
                            anchors.centerIn: parent
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
                    Image{
                        id:nextPageButton_Image
                        source: "../../assets/background/bottonBackground.png"
                        fillMode: Image.PreserveAspectCrop
                        anchors.fill: parent
                        MouseArea{
                            anchors.fill:parent
                            onEntered:{
                                nextPageButton_Image.source = "../../assets/background/buttonBackground2.png"
                                nextPageText.color="#7B0E01"
                            }
                            onExited: {
                                nextPageButton_Image.source ="../../assets/background/bottonBackground.png"
                                nextPageText.color="black"
                            }
                            onPressed: {
                                nextPageButton.opacity =0.5
                            }
                            onReleased: {
                                nextPageButton.opacity =1
                            }
                            onClicked: helpscene.currentPage++
                        }
                        Text {
                            id:nextPageText
                            text: qsTr(">")
                            font.bold: true
                            font.pixelSize: 20
                            font.family: standardFont.name
                            anchors.centerIn: parent
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
}
