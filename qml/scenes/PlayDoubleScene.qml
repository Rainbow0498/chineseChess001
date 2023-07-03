//Author:yangyunbo
//Date:2023.6.16
//Function:Base playScene to finish Double people play chess

import QtQuick 2.15
import Felgo 3.0
import QtMultimedia 5.15
import "../common"
import "../entities"
import "../dialogs"
// EMPTY SCENE

SceneBase {
    id:playDoubleScene
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

        BlackCarChess{ id:blackCar1;index :4 }

        BlackCarChess{ id:blackCar2;index :8 }

        BlackBingChess{ id:blackBing1;index :11 }

        BlackBingChess{ id:blackBing2;index :12 }

        BlackBingChess{ id:blackBing3;index :13 }

        BlackBingChess{ id:blackBing4;index :14 }

        BlackBingChess{ id:blackBing5 ;index :15}

        BlackEleChess{ id:blackEle1;index :2 }

        BlackEleChess{ id:blackEle2;index :6 }

        BlackHorseChess{ id:blackHorse1;index :3 }

        BlackHorseChess{ id:blackHorse2;index :7 }

        BlackShiChess{ id:blackShi1;index :1 }

        BlackShiChess{ id:blackShi2;index :5 }

        BlackShuaiChess{ id:blackShuai;index :0}

        BlackGunChess{ id:blackGun1;index :9 }

        BlackGunChess{ id:blackGun2;index :10 }

        RedCarChess{ id:redCar1;index :4 }

        RedCarChess{ id:redCar2;index :8 }

        RedEleChess{ id:redEle1;index :2 }

        RedEleChess{ id:redEle2;index :6 }

        RedGunChess{ id:redGun1;index :9 }

        RedGunChess{ id:redGun2;index :10 }

        RedHorseChess{ id:redHorse1;index :3 }

        RedHorseChess{ id:redHorse2;index :7 }

        RedShiChess{ id:redShi1;index :1 }

        RedShiChess{ id:redShi2;index :5 }

        RedShuaiChess{ id:redShuai;index :0 }

        RedBingChess{ id:redBing1;index :11 }

        RedBingChess{ id:redBing2;index :12 }

        RedBingChess{ id:redBing3;index :13 }

        RedBingChess{ id:redBing4;index :14 }

        RedBingChess{ id:redBing5;index :15 }

        TapHandler{
            id:checkerboardArea
            onSingleTapped: {
                gameLogic.getChoosePos(point.position.x,point.position.y)
            }
        }

        SpriteSequence{
            id:checkerboardChoose
            width:68
            height:68
            visible: false
            Sprite{
                name:"select1"
                source: "../../assets/select/slected.png"
                frameDuration: 300
                to:{
                    "select2":1
                }
            }
            Sprite{
                name:"select2"
                source: "../../assets/select/wait.png"
                frameDuration: 300
                to:{
                    "select1":1
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
        onClicked: leavePlay.visible = true
    }

    Image {
        id: jiangjun
        width: 100
        height:100
        anchors.centerIn: gameWindowAnchorItem
        fillMode: Image.PreserveAspectCrop
        source: "../../assets/check/jiang.png"
        visible: false
    }

    GameLogic{
        id:gameLogic
    }

    ChooseRules{
        anchors.centerIn: gameWindowAnchorItem
        id: chooseRules
    }

    CannotMove{
        id:cannotMove
        anchors.centerIn: gameWindowAnchorItem
    }

    LeavePlay{
        id:leavePlay
        anchors.centerIn: gameWindowAnchorItem
    }

    MediaPlayer{
        id:eatMusic
        source: "../../assets/audio/eatChess.wav"
        volume: 0.5
        autoPlay: false
    }

    MediaPlayer{
        id:jiangJunMusic
        source: "../../assets/audio/JiangJun.wav"
        volume: 0.5
        autoPlay: false
    }

    Loader{
        id:loader
        //        source:activeLevelFileName !==""? activeLevelFileName:""
        onLoaded:{
            chooseRules.visible = true
        }
    }
}
