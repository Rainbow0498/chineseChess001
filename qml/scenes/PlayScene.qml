//Author:yangyunbo
//Date:2023.6.15
//Function:playScene baseItem with player1 and player2's name and step and every step time

import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
import "../dialogs"
// EMPTY SCENE

SceneBase {
    id:playScene
    height: 960
    width:640


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

    Image{
        id:checkerboard
        width:parent.width
        height:720
        source: "../../assets/background/checkerboard.png"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        //        anchors.topMargin: 50
    }

    Item{
        id:checkerboardIn
        width:parent.width-48*2
        height:checkerboard.height-50*2

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        BlackCarChess{ id:blackCar1 }

        BlackCarChess{ id:blackCar2 }

        BlackBingChess{ id:blackBing1 }

        BlackBingChess{ id:blackBing2 }

        BlackBingChess{ id:blackBing3 }

        BlackBingChess{ id:blackBing4 }

        BlackBingChess{ id:blackBing5 }

        BlackEleChess{ id:blackEle1 }

        BlackEleChess{ id:blackEle2 }

        BlackHorseChess{ id:blackHorse1 }

        BlackHorseChess{ id:blackHorse2 }

        BlackShiChess{ id:blackShi1 }

        BlackShiChess{ id:blackShi2 }

        BlackShuaiChess{ id:blackShuai }

        BlackGunChess{ id:blackGun1 }

        BlackGunChess{ id:blackGun2 }

        RedCarChess{ id:redCar1 }

        RedCarChess{ id:redCar2 }

        RedEleChess{ id:redEle1 }

        RedEleChess{ id:redEle2 }

        RedGunChess{ id:redGun1 }

        RedGunChess{ id:redGun2 }

        RedHorseChess{ id:redHorse1 }

        RedHorseChess{ id:redHorse2 }

        RedShiChess{ id:redShi1 }

        RedShiChess{ id:redShi2 }

        RedShuaiChess{ id:redShuai }

        RedBingChess{ id:redBing1 }

        RedBingChess{ id:redBing2 }

        RedBingChess{ id:redBing3 }

        RedBingChess{ id:redBing4 }

        RedBingChess{ id:redBing5 }

        MouseArea{
            id:checkerboardArea
            anchors.fill: parent
            propagateComposedEvents: true

            onClicked:{
//                mouse.accepted =false
                if(mouse.button===Qt.LeftButton){
                    console.log("鼠标移动坐标:"+(mouseX)+":"+(mouseY))
                    gameLogic.getChoosePos(mouseX,mouseY)
//                    console.log("鼠标左键按下")
                }
            }
        }

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


    GameLogic{
        id:gameLogic
    }

    ChooseRules{
        anchors.centerIn: gameWindowAnchorItem
        id: chooseRules

    }

    Loader{
        id:loader
//        source:activeLevelFileName !==""? activeLevelFileName:""
        onLoaded:{

            chooseRules.visible = true
        }
    }





}
