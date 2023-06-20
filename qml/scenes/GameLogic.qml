//Author:yangyunbo
//Date:2023.6.19
//Function:The Chess all rules and how to play the game

import QtQuick 2.0
import Felgo 3.0
Item {
    id:gameLogic
    property int lastRow
    property int lastCol
    property int index
    property bool canMove
    property int camp
    property bool dead
    property int newRow:-1
    property int newCol:-1
    property int stepCount //总步数
    property int mouseCount //区域点击次数
    property int lineCount

    function getChoosePos(mouseX,mouseY){
        newCol = (mouseX+34)/68
        newRow = (mouseY+34)/68
        checkerboardChoose.visible = true
        checkerboardChoose.x = newCol * 68-34
        checkerboardChoose.y = newRow * 68-34
        if(mouseCount == 0 && getID(newRow,newCol)===null){
            newCol =-1
            newRow =-1
        }
        else {
            if(getID(newRow,newCol) ===null){
                mouseCount++
            }
            else{
                if(getID(newRow,newCol).isDead !==true){
                        mouseCount++
                }
            }
        }
        if(mouseCount === 1){
            lastRow = newRow
            lastCol = newCol
            camp = getID(newRow,newCol).camp
//            updateTime()
            if((stepCount%2==0&&getID(lastRow,lastCol).camp!==1)||(stepCount%2==1&&getID(lastRow,lastCol).camp!==0)){
                mouseCount--
                cannotMove.visible =true
            }
        }
        else if(mouseCount === 2 && getID(newRow,newCol)!==null){
            if(getID(newRow,newCol).camp===camp)
            {
                mouseCount--
                lastRow = newRow
                lastCol = newCol
            }
            else{
                if(eatChess(lastRow,lastCol,newRow,newCol)){
                    stepCount++
                    mouseCount = 0
                }else{
                    mouseCount--
                }
            }
        }
        else if(mouseCount === 2){
            if(updateChessPos(lastRow,lastCol,newRow,newCol))
            {
                stepCount++
                mouseCount =0
            }
            else {
                mouseCount--
            }
        }
    }

//    function updateTime(){
//        if(stepCount%2==0){
//            player1.timeStart
//        }else{
//            player2.timeStart.start()
//        }
//    }

    function updateChessPos(lastY,lastX,newY,newX){
        index = getID(lastY,lastX).index
        switch(index){
        case 0:
            canMove = isShuaiMove()
            break
        case 1:
            canMove = isShiMove()
            break
        case 2:
            canMove = isEleMove()
            break
        case 3:
            canMove = isHorseMove()
            break
        case 4:
            canMove = isCarMove()
            break
        case 5:
            canMove = isGunMove()
            break
        case 6:
            canMove = isBingMove()
            break
        }

        if(canMove){
            move.start()
            index = getID(lastRow,lastCol).index
            if(isGeneral(index)){
                jiangjun.visible = true
                jiangJunMusic.play()
            }else{
                jiangjun.visible = false
            }

            return true
        }else return false
    }

    function eatChess(lastRow,lastCol,newRow,newCol){
        if(updateChessPos(lastRow,lastCol,newRow,newCol)){
            eatMusic.play()
            getID(newRow,newCol).isDead = true;
            return true
        }else return false
    }

    function isGeneral(index){
        lastRow=newRow
        lastCol=newCol
        newRow=(stepCount%2==0)?blackShuai.row:redShuai.row
        newCol=(stepCount%2==0)?blackShuai.col:redShuai.col
        switch(index){
        case 0:
            return isShuaiMove()
        case 1:
            return isShiMove()
        case 2:
            return isEleMove()
        case 3:
            return isHorseMove()
        case 4:
            return isCarMove()
        case 5:
            return isGunMove()
        case 6:
            return isBingMove()
        }
//        return false
    }

    function isShuaiMove(){
        if(camp==1){
            if((newCol<3||newCol>5)||newRow<7)
                return false
            else{
                if(newCol ==lastCol)
                {
                    if(Math.abs(newRow-lastRow)===1)
                        return true
                    return false
                }else if(newRow ==lastRow){
                    if(Math.abs(newCol-lastCol)===1){
                        return true
                    }
                    return false
                }
            }
        }else{
            if((newCol<3||newCol>5)||newRow>2)
                return false
            else{
                if(newCol ==lastCol)
                {
                    if(Math.abs(newRow-lastRow)===1)
                        return true
                    return false
                }else if(newRow ==lastRow){
                    if(Math.abs(newCol-lastCol)===1){
                        return true
                    }
                    return false
                }
            }
        }


    }

    function isShiMove(){
        if(camp==1){
            if((newCol<3||newCol>5)||newRow<7)
                return false
            else{
                if(Math.abs(newCol-lastCol)===1&&Math.abs(newRow-lastRow)===1){
                    return true
                }
                else return false
            }
        }
        else{
            if((newCol<3||newCol>5)||newRow>2)
                return false
            else{
                if(Math.abs(newCol-lastCol)===1&&Math.abs(newRow-lastRow)===1){
                    return true
                }
                else return false
            }
        }
    }

    function isEleMove(){
        if(camp==1){
            if(newRow>=5){
                if(Math.abs(newCol-lastCol)===2&&Math.abs(newRow-lastRow)===2) return true
                else return false
            }else
                return false
        }
        else if(camp==0){
            if(newRow<=4){
                if(Math.abs(newCol-lastCol)===2&&Math.abs(newRow-lastRow)===2) return true
                else return false
            }else
                return false
        }
    }

    function isHorseMove(){
        if((newCol-lastCol===1&&newRow-lastRow===2)||(newCol-lastCol===-1&&newRow-lastRow===2)){
            if(getID((newRow+lastRow)/2,lastCol)!==null)
                return false
            else return true
        }
        else if((newCol-lastCol===1&&newRow-lastRow===-2)||(newCol-lastCol===-1&&newRow-lastRow===-2)){
            if(getID((newRow+lastRow)/2,lastCol)!==null)
                return false
            else return true
        }
        else if((newCol-lastCol===2&&newRow-lastRow===1)||(newCol-lastCol===2&&newRow-lastRow===-1)){
            if(getID(lastRow,(lastCol+newCol)/2)!==null)
                return false
            else return true
        }
        else if((newCol-lastCol===-2&&newRow-lastRow===1)||(newCol-lastCol===-2&&newRow-lastRow===-1))
        {
            if(getID(lastRow,(lastCol+newCol)/2)!==null)
                return false
            else return true
        }
        else return false
    }

    function isCarMove(){
        if(newRow===lastRow||newCol===lastCol){
            getChessCountAtLine(newRow,newCol,lastRow,lastCol)

            if(lineCount===0)
                return true
            else return false
        }
        else return false
    }

    function isGunMove(){
        if(newRow===lastRow||newCol===lastCol){
            getChessCountAtLine(newRow,newCol,lastRow,lastCol)
            if(getID(newRow,newCol)!==null){
                if(lineCount===1){
                    return true
                }
                else {
                    return false
                }
            }else{
                if(lineCount===0)
                    return true
                else return false
            }
        }
        else return false
    }

    // 车，炮使用该函数，判断走的路径上有多少棋子
    function getChessCountAtLine(newY,newX,lastY,lastX){
        lineCount =0
        var lineLength
        if(newY===lastY){
            lineLength = newX-lastX
            if(lineLength<0){
                for(var i =newX+1;i<lastX;i++){
                    if(getID(newY,i)!==null)
                        lineCount++
                }
                return lineCount
            }else{
                for(var j =lastX+1;j<newX;j++){
                    if(getID(newY,j)!==null)
                        lineCount++
                }
                return lineCount
            }
        }else if(newX===lastX){
            lineLength = newY-lastY
            if(lineLength<0){
                for(var a =newY+1;a<lastY;a++){
                    console.log(a+"    "+ newX)
                    if(getID(a,newX)!==null)
                        lineCount++
                }
                return lineCount
            }else{
                for(var b =lastY+1;b<newY;b++){
                    console.log(b+"    "+ newX)
                    if(getID(b,newX)!==null)
                        lineCount++
                }
                return lineCount
            }
        }
    }

    function isBingMove(){
        if(camp==1){
            if(newRow>4){
                if(newCol==lastCol)
                {
                    if(newRow-lastRow===-1)
                        return true
                    else return false
                }
                else return false
            }else{
                if(newCol==lastCol)
                {
                    if(newRow-lastRow===-1)
                        return true
                    else return false
                }
                else if(newRow==lastRow)
                {
                    if(Math.abs(newCol-lastCol)===1)
                        return true
                    else return false
                }
            }
        }
        else{
            if(newRow<5){
                if(newCol==lastCol)
                {
                    if(newRow-lastRow===1)
                        return true
                    else return false
                }
                else return false
            }else{
                if(newCol==lastCol)
                {
                    if(newRow-lastRow===1)
                        return true
                    else return false
                }
                else if(newRow==lastRow)
                {
                    if(Math.abs(newCol-lastCol)===1)
                        return true
                    else return false
                }
            }
        }
    }

    ParallelAnimation{
        id:move
        NumberAnimation{
            target:getID(lastRow,lastCol)
            property: "row"
            to:newRow
            duration: 100
        }
        NumberAnimation{
            target:getID(lastRow,lastCol)
            property: "col"
            to:newCol
            duration: 100
        }
    }

    function initGame(){
        //init the AllStep
        stepCount = 0
        //init blackChess
        blackShuai.row = 0; blackShuai.col = 4;
        blackShi1.row = 0; blackShi1.col = 3;
        blackShi2.row = 0; blackShi2.col = 5;
        blackEle1.row = 0; blackEle1.col = 2;
        blackEle2.row = 0; blackEle2.col = 6;
        blackHorse1.row = 0; blackHorse1.col = 1;
        blackHorse2.row = 0; blackHorse2.col = 7;
        blackCar1.row = 0; blackCar1.col = 0;
        blackCar2.row = 0; blackCar2.col = 8;
        blackGun1.row = 2; blackGun1.col = 1;
        blackGun2.row = 2; blackGun2.col = 7;
        blackBing1.row = 3; blackBing1.col = 0;
        blackBing2.row = 3; blackBing2.col = 2;
        blackBing3.row = 3; blackBing3.col = 4;
        blackBing4.row = 3; blackBing4.col = 6;
        blackBing5.row = 3; blackBing5.col = 8;
        //init RedChess
        redShuai.row = 9; redShuai.col = 4;
        redShi1.row = 9; redShi1.col = 3;
        redShi2.row = 9; redShi2.col = 5;
        redEle1.row = 9; redEle1.col = 2;
        redEle2.row = 9; redEle2.col = 6;
        redHorse1.row = 9; redHorse1.col = 1;
        redHorse2.row = 9; redHorse2.col = 7;
        redCar1.row = 9; redCar1.col = 0;
        redCar2.row = 9; redCar2.col = 8;
        redGun1.row = 7; redGun1.col = 1;
        redGun2.row = 7; redGun2.col = 7;
        redBing1.row = 6; redBing1.col = 0;
        redBing2.row = 6; redBing2.col = 2;
        redBing3.row = 6; redBing3.col = 4;
        redBing4.row = 6; redBing4.col = 6;
        redBing5.row = 6; redBing5.col = 8;
    }

    function getID(row, col) {
        if( blackShuai.row ===row && blackShuai.col ===col &&blackShuai.isDead!==true) { return blackShuai }
        else if( blackShi1.row ===row && blackShi1.col ===col &&blackShi1.isDead!==true) { return blackShi1 }
        else if( blackShi2.row ===row && blackShi2.col ===col &&blackShi2.isDead!==true) { return blackShi2 }
        else if( blackEle1.row ===row && blackEle1.col ===col &&blackEle1.isDead!==true) { return blackEle1 }
        else if( blackEle2.row ===row && blackEle2.col ===col &&blackEle2.isDead!==true) { return blackEle2 }
        else if( blackHorse1.row ===row && blackHorse1.col ===col &&blackHorse1.isDead!==true) { return blackHorse1 }
        else if( blackHorse2.row ===row && blackHorse2.col ===col &&blackHorse2.isDead!==true) { return blackHorse2 }
        else if( blackCar1.row ===row && blackCar1.col ===col &&blackCar1.isDead!==true) { return blackCar1 }
        else if( blackCar2.row ===row && blackCar2.col ===col &&blackCar2.isDead!==true) { return blackCar2 }
        else if( blackGun1.row ===row && blackGun1.col ===col &&blackGun1.isDead!==true) { return blackGun1 }
        else if( blackGun2.row ===row && blackGun2.col ===col &&blackGun2.isDead!==true) { return blackGun2 }
        else if( blackBing1.row ===row && blackBing1.col ===col &&blackBing1.isDead!==true) { return blackBing1 }
        else if( blackBing2.row ===row && blackBing2.col ===col &&blackBing2.isDead!==true) { return blackBing2 }
        else if( blackBing3.row ===row && blackBing3.col ===col &&blackBing3.isDead!==true) { return blackBing3 }
        else if( blackBing4.row ===row && blackBing4.col ===col &&blackBing4.isDead!==true) { return blackBing4 }
        else if( blackBing5.row ===row && blackBing5.col ===col &&blackBing5.isDead!==true) { return blackBing5 }

        else if( redShuai.row ===row && redShuai.col ===col &&redShuai.isDead!==true) { return redShuai }
        else if( redShi1.row ===row && redShi1.col ===col &&redShi1.isDead!==true) { return redShi1}
        else if( redShi2.row ===row && redShi2.col ===col &&redShi2.isDead!==true) { return redShi2 }
        else if( redEle1.row ===row && redEle1.col ===col &&redEle1.isDead!==true) { return redEle1 }
        else if( redEle2.row ===row && redEle2.col ===col &&redEle2.isDead!==true) { return redEle2 }
        else if( redHorse1.row ===row && redHorse1.col ===col &&redHorse1.isDead!==true) { return redHorse1 }
        else if( redHorse2.row ===row && redHorse2.col ===col &&redHorse2.isDead!==true) { return redHorse2 }
        else if( redCar1.row ===row && redCar1.col ===col &&redCar1.isDead!==true) { return redCar1 }
        else if( redCar2.row ===row && redCar2.col ===col &&redCar2.isDead!==true) { return redCar2 }
        else if( redGun1.row ===row && redGun1.col ===col &&redGun1.isDead!==true) { return redGun1 }
        else if( redGun2.row ===row && redGun2.col ===col &&redGun2.isDead!==true) { return redGun2 }
        else if( redBing1.row ===row && redBing1.col ===col &&redBing1.isDead!==true) { return redBing1 }
        else if( redBing2.row ===row && redBing2.col ===col &&redBing2.isDead!==true) { return redBing2 }
        else if( redBing3.row ===row && redBing3.col ===col &&redBing3.isDead!==true) { return redBing3 }
        else if( redBing4.row ===row && redBing4.col ===col &&redBing4.isDead!==true) { return redBing4 }
        else if( redBing5.row ===row && redBing5.col ===col &&redBing5.isDead!==true) { return redBing5 }
        else return null
    }
}
