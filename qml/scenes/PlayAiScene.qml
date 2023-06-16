//Author:yangyunbo
//Date:2023.6.16
//Function:Base playScene to finish AI play chess

import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../entities"
// EMPTY SCENE

LevelBase {
    levelName:"PlayAiScene"

    Rectangle{
        anchors.centerIn: parent
        BackgroundImage{
            source: "../../assets/background/checkboard-back1.png"
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }

        Rectangle{
            id:black
            height:parent.height/2


        }

        Rectangle{
            id:red
            height:parent.height/2

            RedCarChess{

            }
        }
    }







}
