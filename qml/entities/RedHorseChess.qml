//Author:yangyunbo
//Date:2023.6.16
//Function:Red Horse Chess

import QtQuick 2.0
import Felgo 3.0
import "../common"
RedBase {
    id:redHorseChess
    entityId: "redHorseChess"
    entityType: "boxEntity"
    index: 3
    source: "../../assets/red/RM.png"

    MouseArea{
        anchors.fill:parent
        onClicked:{
            mouse.accepted =false
            if(mouse.button===Qt.LeftButton){
                gameLogic.setChessPos(parent.x,parent.y,camp,index)
            }
        }
    }
}
