//Function:Button to switch window

import QtQuick 2.15
import Felgo 3.0
Rectangle {
    id: button
    // this will be the default size, it is same size as the contained text + some padding
    width: buttonText.width+ paddingHorizontal*2
    height: buttonText.height+ paddingVertical*2
    color: "#e9e9e9"
    radius: 10
    z:10
    // the horizontal margin from the Text element to the Rectangle at both the left and the right side.
    property int paddingHorizontal: 10
    // the vertical margin from the Text element to the Rectangle at both the top and the bottom side.
    property int paddingVertical: 5

    // access the text of the Text component
    property alias text: buttonText.text
    property alias size:buttonText.font.pixelSize
    property alias bold:buttonText.font.bold
    property alias buttonImage: buttonImage
    property alias tap:tapArea
    // this handler is called when the button is clicked.
    signal clicked

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 18
        font.bold: false
        color: "black"
    }

    Image {
      id: buttonImage
      source: ""
      anchors.fill: parent
      smooth: true
    }

    TapHandler{
        id:tapArea
        onTapped: button.clicked()
    }
}
