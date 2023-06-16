//Author:yangyunbo
//Date:6.15
//Function:Player1 Base
import QtQuick 2.0
import Felgo 3.0
import "../common"
PlayerBase {
    id:player1
    property int step:0

    height:name.height+stepCount.height+p1time.height

    Column{
        spacing: 10
        Text {
            id: name
            text: qsTr("player1")
        }
        Text{
            id:stepCount
            text: step+" step"
        }
        Text{
            id:p1time
            text:"stepTime: "+time
        }
    }
}
