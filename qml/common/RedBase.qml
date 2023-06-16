//Author:yangyunbo
//Date:2023.6.15
//Function:Red chess baseEntity

import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:red
    entityId: "red"
    width:65
    height:65
    property alias source: redImage.source
    Image {
        id: redImage
        source: ""
        anchors.fill: parent
    }

}
