import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15
import Felgo 3.0
import "../common"

SceneBase{
    id:helpscene

    Rectangle {
        id:mainWindow
        anchors.fill: parent.gameWindowAnchorItem

        BackgroundImage{
            source: "../../assets/background/checkerboard-back2.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }


        Text {
            id: helpText
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("About")
            font.bold: true
            font.family: standardFont.name
            font.pixelSize: 48
        }
        Rectangle{
            height: 200
            width:200
            color: "transparent"
            anchors.centerIn: parent
            ColumnLayout{
                anchors.fill:parent
                ScrollView{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    TextArea {
                        id: helpContent
                        width: parent.width
                        text: qsTr("This is a ChineseChess Game.You can play the game with your friend...
                                        you can also choose to play yourself or play with AI,we really hope you can enjoy our game")
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


        MenuButton{
            id:backButton
            width:70
            height: 30
            x:30
            y:30
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
    }

}
