import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2
import Felgo 3.0

Scene{
    Rectangle {
        id:mainWindow
        anchors.fill: parent.gameWindowAnchorItem

        BackgroundImage{
            source: "../../assets/background/checkerboard-back2.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
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
        RowLayout{
            Text{
                text: "Sound Switch"
            }
            Switch{
                id:soundSwitch
                Layout.fillWidth: true
            }
        }

        ComboBox{
            id:backgroundComboBox

            width: settingColumn.width
            height: 50
            model:["background1","background2"]
            currentIndex: 0
        }

    }

}
