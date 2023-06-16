//Author:yangyunbo
//Date:2023.6.14
//Function:Player baseEntity and handle the every step time

import QtQuick 2.0
import Felgo 3.0

Item {
    id:player
    property string time:minute +" minute: "+second+" second"

    property int minute
    property int second

    Timer{
        id:stepTimeChange
        interval: 1000
        repeat: true
        onTriggered: {
            second-=1;
            if(second==0)
            {
                minute -=1;
                second =60;
            }
        }
    }
}
