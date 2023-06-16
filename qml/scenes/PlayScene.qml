//Author:yangyunbo
//Date:2023.6.15
//Function:playScene baseItem with player1 and player2's name and step and every step time

import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
// EMPTY SCENE

SceneBase {
    id:playScene
    height: 960
    width:640
    property string activeLevelFileName
    property variant activeLevel

    function setLevel(fileName)
    {
        activeLevelFileName = fileName
    }

    Image{
        id:background
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/background/checkerboard-back1.png"
        fillMode: Image.PreserveAspectCrop
        smooth:true
    }

    Player1{
        id:player1

        anchors.bottom: gameWindowAnchorItem.bottom
        anchors.bottomMargin: 20
        anchors.left: gameWindowAnchorItem.left
        anchors.leftMargin: 20
    }

    Player2{
        id:player2
        anchors.top: gameWindowAnchorItem.top
        anchors.topMargin: 20
        anchors.left: gameWindowAnchorItem.left
        anchors.leftMargin: 20
    }


    ButtonBase {
      id: backButton
      width: 50
      height: 50
      buttonImage.source: "../../assets/background/Home.png"
      anchors.right: gameWindowAnchorItem.right
      anchors.rightMargin: 20
      anchors.top: gameWindowAnchorItem.top
      anchors.topMargin: 20
      onClicked: leaveGame.visible = true
    }

    Loader{
        id:loader

        source:activeLevelFileName !==""? activeLevelFileName:""
        onLoaded:{
            item.width = playScene.width
            item.height = playScene.height
            activeLevel =item
        }
    }

    Connections{
        target:activeLevel !==undefined ?activeLevel :null


    }

}
