//Author:yangyunbo
//Date:2023.6.16
//Function:Base playScene to finish Own play chess

import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
// EMPTY SCENE

LevelBase {
    levelName:"PlayOwnScene"
    //    width:parent
    //    height:parent
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

        BlackCarChess{
            x:checkerboardIn.width/2-width/2-68*4
            y:0-height/2
        }

        BlackCarChess{
            x:checkerboardIn.width/2-width/2+68*4
            y:0-height/2
        }

        BlackBingChess{
            x:checkerboardIn.width/2-width/2-68*4
            y:68*3-height/2
        }

        BlackBingChess{
            x:checkerboardIn.width/2-width/2-68*2
            y:68*3-height/2
        }

        BlackBingChess{
            x:checkerboardIn.width/2-width/2
            y:68*3-height/2
        }

        BlackBingChess{
            x:checkerboardIn.width/2-width/2+68*4
            y:68*3-height/2
        }

        BlackBingChess{
            x:checkerboardIn.width/2-width/2+68*2
            y:68*3-height/2
        }

        BlackEleChess{
            x:checkerboardIn.width/2-width/2-68*2
            y:0-height/2
        }

        BlackEleChess{
            x:checkerboardIn.width/2-width/2+68*2
            y:0-height/2
        }

        BlackHorseChess{
            x:checkerboardIn.width/2-width/2-68*3
            y:0-height/2
        }

        BlackHorseChess{
            x:checkerboardIn.width/2-width/2+68*3
            y:0-height/2
        }

        BlackShiChess{
            x:checkerboardIn.width/2-width/2-68
            y:0-height/2
        }

        BlackShiChess{
            x:checkerboardIn.width/2-width/2+68
            y:0-height/2
        }

        BlackShuaiChess{
            x:checkerboardIn.width/2-width/2
            y:0-height/2
        }

        BlackGunChess{
            x:checkerboardIn.width/2-width/2-68*3
            y:68*2-height/2
        }

        BlackGunChess{
            x:checkerboardIn.width/2-width/2+68*3
            y:68*2-height/2
        }

        RedCarChess{
            x:checkerboardIn.width/2-width/2-68*4
            y:68*9-height/2
        }

        RedCarChess{
            x:checkerboardIn.width/2-width/2+68*4
            y:68*9-height/2
        }

        RedEleChess{
            x:checkerboardIn.width/2-width/2-68*2
            y:68*9-height/2
        }

        RedEleChess{
            x:checkerboardIn.width/2-width/2+68*2
            y:68*9-height/2
        }

        RedGunChess{
            x:checkerboardIn.width/2-width/2-68*3
            y:68*7-height/2
        }

        RedGunChess{
            x:checkerboardIn.width/2-width/2+68*3
            y:68*7-height/2
        }

        RedHorseChess{
            x:checkerboardIn.width/2-width/2-68*3
            y:68*9-height/2
        }

        RedHorseChess{
            x:checkerboardIn.width/2-width/2+68*3
            y:68*9-height/2
        }

        RedShiChess{
            x:checkerboardIn.width/2-width/2-68
            y:68*9-height/2
        }

        RedShiChess{
            x:checkerboardIn.width/2-width/2+68
            y:68*9-height/2
        }

        RedShuaiChess{
            x:checkerboardIn.width/2-width/2
            y:68*9-height/2
        }

        RedBingChess{
            x:checkerboardIn.width/2-width/2-68*4
            y:68*6-height/2
        }

        RedBingChess{
            x:checkerboardIn.width/2-width/2-68*2
            y:68*6-height/2
        }

        RedBingChess{
            x:checkerboardIn.width/2-width/2
            y:68*6-height/2
        }

        RedBingChess{
            x:checkerboardIn.width/2-width/2+68*2
            y:68*6-height/2
        }

        RedBingChess{
            x:checkerboardIn.width/2-width/2+68*4
            y:68*6-height/2
        }
    }


}
