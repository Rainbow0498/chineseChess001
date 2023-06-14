import QtQuick 2.0
import QtQuick.Controls 2.0
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
}
