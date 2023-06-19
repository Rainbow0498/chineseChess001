//Author:yangyunbo
//Date:2023.6.16
//Function:Red car and go line

import QtQuick 2.15
import Felgo 3.0
import "../common"
RedBase {
    id:redCarChess
    entityId: "redCarChess"
    entityType: "boxEntity"
    index: 4
    source: "../../assets/red/RC.png"
//    TapHandler{
//        onTapped: {
//            gameLogic.setChessPos(parent.x,parent.y,camp,index)
//        }
//    }

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
