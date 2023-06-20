//Author:yangyunbo
//Date:2023.6.15
//Function:Red chess baseEntity

import QtQuick 2.15
import QtQuick.Controls 2.15
import Felgo 3.0

EntityBase {
    id:red
    entityId: "red"
    width:68
    height:68
    property alias source: redImage.source
    property int camp :1
    property int index
    property int row
    property int col
    property bool isDead: false
    x: col * 68-width/2
    y: row * 68-height/2
    visible: !isDead
    focus: false
//    z:110

    Image {
        id: redImage
        source: ""
        anchors.fill: parent
    }

    Image {
        id: selectBorder
        source: "../../assets/select/slected.png"
        visible: focus
    }

}
