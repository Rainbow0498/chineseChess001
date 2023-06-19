//Author:yangyunbo
//Date:2023.6.16
//Function:Black chess baseEntity

import QtQuick 2.15
import Felgo 3.0

EntityBase {
    id:black
    entityId: "black"
    width:68
    height:68
    property alias source: blackImage.source
    property int camp :0
    property bool isDead: false
    property int row
    property int col
    property int index
    x: col * 68-width/2
    y: row * 68-height/2
    visible: !isDead
//    z:110
    Image {
        id: blackImage
        source: ""
        anchors.fill: parent
    }
    TapHandler{
        acceptedButtons: Qt.LeftButton
    }
}
