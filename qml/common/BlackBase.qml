//Author:yangyunbo
//Date:2023.6.16
//Function:Black chess baseEntity

import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:black
    entityId: "black"
    width:65
    height:65
    property alias source: blackImage.source
    Image {
        id: blackImage
        source: ""
        anchors.fill: parent
    }

}
