//Author:yangyunbo
//Date:6.15
//Function:Player2 Base
import QtQuick 2.0
import Felgo 3.0
import "../common"
PlayerBase {
    id:player2

    property int step:0
    height:name.height+stepCount.height+p2time.height

    Column{
        spacing: 10
        Text {
            id: name
            text: qsTr("player2")
        }
        Text{
            id:stepCount
            text: step+" step"
        }
        Text{
            id:p2time
            text:"stepTime: "+time
        }
    }


}
