//Author:yangyunbo
//Date:2023.6.19
//Function:The Chess all rules and how to play the game

import QtQuick 2.0
import Felgo 3.0

Item {
    id:gameLogic

    signal communication

    property int lastRow
    property int lastCol
    property int index //记录选中棋子的类型
    property bool canMove
    property int camp //记录选中阵营
    property int newRow:-1
    property int newCol:-1
    property int aiLastRow:-1
    property int aiLastCol:-1
    property int aiRow:-1
    property int aiCol:-1
    property int stepCount //总步数
    property int mouseCount //区域点击次数
    property int lineCount //记录这条线上有多少棋子，炮和车使用




    //单人和双人对战处理逻辑
    function getChoosePos(mouseX,mouseY){
        newCol = (mouseX+34)/68
        newRow = (mouseY+34)/68
        checkerboardChoose.visible = true
        checkerboardChoose.x = newCol * 68-34
        checkerboardChoose.y = newRow * 68-34
        if(playDoubleScene.isConnected){
            playDoubleScene.newCol = newCol
            playDoubleScene.newRow = newRow
        }
        if(mouseCount == 0 && getID(newRow,newCol)===null){//判断是否点击棋子
            newCol =-1
            newRow =-1
        }
        else {
            if(getID(newRow,newCol) ===null){//点击位置没有棋子
                mouseCount++
            }
            else{
                if(getID(newRow,newCol).isDead !==true){//点击位置棋子存在
                    mouseCount++
                }
            }
        }
        if(mouseCount === 1){//第一次点击成功后获取棋子的坐标和阵营，并通过总步数判断是否该这个阵营移动
            lastRow = newRow
            lastCol = newCol
            camp = getID(newRow,newCol).camp
            //            updateTime()
            if(playDoubleScene.isConnected){
                playDoubleScene.lastCol = lastCol
                playDoubleScene.lastRow = lastRow
            }

            if((stepCount%2==0&&getID(lastRow,lastCol).camp!==1)||(stepCount%2==1&&getID(lastRow,lastCol).camp!==0)){
                mouseCount--
                cannotMove.visible =true
            }
        }
        else if(mouseCount === 2 && getID(newRow,newCol)!==null){
            if(getID(newRow,newCol).camp===camp)//第二次点击若为相同阵营棋子，则更改选中棋子
            {
                mouseCount--
                lastRow = newRow
                lastCol = newCol
                if(playDoubleScene.isConnected){
                    playDoubleScene.lastCol = lastCol
                    playDoubleScene.lastRow = lastRow
                }
            }
            else{
                if(eatChess(lastRow,lastCol,newRow,newCol)){//如果不是相同阵营则判断是否能吃子，不能吃子则无法移动，能吃子则移动
                    mouseCount = 0
                    if(playDoubleScene.isConnected)
                        communication()
                }else{
                    mouseCount--
                }
            }
        }
        else if(mouseCount === 2){//如果点击位置没有棋子，则直接判断棋子是否能够移动到那个位置
            if(updateChessPos(lastRow,lastCol,newRow,newCol))
            {
                mouseCount =0
                if(playDoubleScene.isConnected)
                    communication()
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

    function moveChess(lastY,lastX,newY,newX){
        lastCol = lastX
        lastRow = lastY
        newRow = newY
        newCol = newX
        console.log(lastCol +" "+ lastRow+" " +newRow +" "+newCol)
        if(getID(newY,newX)!==null){
            console.log(getID(newY,newX))
            if(getID(newY,newX)===redShuai){
                console.log(11)
                gameOver.winner = false
                gameOver.visible = true
            }else if(getID(newY,newX)===blackShuai){
                console.log(11)
                gameOver.winner = true
                gameOver.visible = true
            }
            getID(newY,newX).isDead = true

        }
        stepCount++
        move.start()
    }

    //移动棋子函数
    function updateChessPos(lastY,lastX,newY,newX){
        console.log(lastY+" "+lastX+" "+newY+" "+newX)
        index = getID(lastY,lastX).index
        console.log(index)
        switch(index){
        case 0:
            canMove = isShuaiMove()
            break
        case 1:
        case 5:
            canMove = isShiMove()
            break
        case 2:
        case 6:
            canMove = isEleMove()
            break
        case 3:
        case 7:
            canMove = isHorseMove()
            break
        case 4:
        case 8:
            canMove = isCarMove()
            break
        case 9:
        case 10:
            canMove = isGunMove()
            break
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            canMove = isBingMove()
            break
        }

        if(canMove){
            move.start()          
            index = getID(lastY,lastX).index
            if(isGeneral(index)){
                jiangjun.visible = true
                jiangJunMusic.play()
            }else{
                jiangjun.visible = false
            }
            stepCount++
            return true
        }else return false
    }
//吃子使用该函数
    function eatChess(lastRow,lastCol,newRow,newCol){
        if(updateChessPos(lastRow,lastCol,newRow,newCol)){
            eatMusic.play()
            console.log(getID(newRow,newCol))
            if(getID(newRow,newCol)===redShuai){
                gameOver.winner = false
                gameOver.visible = true
            }else if(getID(newRow,newCol)===blackShuai){
                gameOver.winner = true
                gameOver.visible = true
            }
            getID(newRow,newCol).isDead = true;
            return true
        }else return false
    }
//判断是否将军
    function isGeneral(index){
        lastRow=newRow
        lastCol=newCol
        newRow=(stepCount%2==0)?blackShuai.row:redShuai.row
        newCol=(stepCount%2==0)?blackShuai.col:redShuai.col
        switch(index){
        case 0:
            return isShuaiMove()
        case 1:
        case 5:
            return isShiMove()
        case 2:
        case 6:
            return isEleMove()
        case 3:
        case 7:
            return isHorseMove()
        case 4:
        case 8:
            return isCarMove()
        case 9:
        case 10:
            return isGunMove()
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            return isBingMove()
        }
        //        return false
    }
//判断帅能否移动
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
//判断士能否移动
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
//判断象能否移动
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
//判断马能否移动
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
//判断车能否移动
    function isCarMove(){
        if(newRow===lastRow||newCol===lastCol){
            getChessCountAtLine(newRow,newCol,lastRow,lastCol)

            if(lineCount===0)
                return true
            else return false
        }
        else return false
    }
//判断炮能否移动
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


    //AI对战处理逻辑
    function getAIChoosePos(mouseX,mouseY){
        if(stepCount%2==1){
            machineMovePiece()
            stepCount++
            checkerboardChoose.visible = true
            checkerboardChoose.x = aiCol * 68-34
            checkerboardChoose.y = aiRow * 68-34
        }else if(stepCount%2 == 0){
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
                        mouseCount = 0

                    }else{
                        mouseCount--
                    }
                }
            }
            else if(mouseCount === 2){
                if(updateChessPos(lastRow,lastCol,newRow,newCol))
                {
                    mouseCount =0

                }
                else {
                    mouseCount--
                }
            }
        }
    }


    //计算最好的局面分
    function calcScore(){
        var redGrossScore = 0
        var blackGrossScore = 0
        console.log(redGrossScore,blackGrossScore)
        //这些数值代表棋子的分数，分别为将、士、相、马、车、炮、兵
        var chessScore = [200,20,40,60,100,20,40,60,100,80,80,10,10,10,10,10]

        for(var row = 0;row<10;row++){
            for(var col =0 ;col<9;col++)
            {
                if(getID(row,col)!==null&&getID(row,col).camp===1&&getID(row,col).isDead!==true){
                    redGrossScore += chessScore[getID(row,col).index]
                }else if(getID(row,col)!==null&&getID(row,col).camp===0&&getID(row,col).isDead!==true){
                    blackGrossScore +=chessScore[getID(row,col).index]
                }
            }
        }
        console.log(redGrossScore,blackGrossScore)
        return (blackGrossScore - redGrossScore)
    }
//假装移动（让移动的那个棋子死亡）为了方便计算场面分
    function fakeMove(row,col){
        getID(row,col).isDead = true
    }
//回滚
    function unFakeMove(index,camp){
        getID1(index,camp).isDead = false
    }
//AI移动的函数
    function machineMovePiece(){
        console.log(lastRow+" "+lastCol)
        var maxScore = -10000
//第一重循环是为了获取所有的黑子，第二重循环里获取所有的红字，然后通过黑子的类型来依次判断能不能吃掉红子，若能吃掉，就计算如果移动这步能导致场面分增加还是减少，增加保留该移动步骤，减少就不管继续下一次循环
        for(var index =0;index<16;index++){
            lastRow = getID1(index,0).row
            lastCol = getID1(index,0).col
            camp = getID1(index,0).camp
            for(var index2 = 0;index2<16;index2++){
                newRow = getID1(index2,1).row
                newCol = getID1(index2,1).col
                switch(index){
                case 0:
                    canMove = isShuaiMove()
                    break
                case 1:
                case 5:
                    canMove = isShiMove()
                    break
                case 2:
                case 6:
                    canMove = isEleMove()
                    break
                case 3:
                case 7:
                    canMove = isHorseMove()
                    break
                case 4:
                case 8:
                    canMove = isCarMove()
                    break
                case 9:
                case 10:
                    canMove = isGunMove()
                    break
                case 11:
                case 12:
                case 13:
                case 14:
//                case 15:
//                    canMove = isBingMove()
//                    break
                default: break
                }
//                console.log(canMove)
                if(canMove){
                    fakeMove(newRow,newCol)
                    var score = calcScore()
//                    console.log(score)
                    unFakeMove(index2,1)

                    if(score > maxScore){
                        maxScore = score
                        aiLastCol = lastCol
                        aiLastRow = lastRow
                        aiRow = newRow
                        aiCol = newCol
                    }
                }else{
                    continue
                }
            }
        }
//若黑子能够吃掉红子，就开始吃掉红子，不能吃掉红子就随机一个黑子让他向下移动一格
        if(maxScore>0){
            getID(aiRow,aiCol).isDead = true
            moveAI.start()
        }else{
            var a = parseInt(Math.random()*16)
            console.log(a)
            aiLastRow = getID1(a,0).row
            aiLastCol = getID1(a,0).col
            aiRow = aiLastRow+1
            aiCol = aiLastCol
            console.log(aiLastRow,aiLastCol,aiRow,aiCol)
            moveAI.start()
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

    ParallelAnimation{
        id:moveAI
        NumberAnimation{
            target:getID(aiLastRow,aiLastCol)
            property: "row"
            to:aiRow
            duration: 100
        }
        NumberAnimation{
            target:getID(aiLastRow,aiLastCol)
            property: "col"
            to:aiCol
            duration: 100
        }
    }

    function initGame(){
        //init the AllStep
        stepCount = 0
        //init blackChess
        blackShuai.row = 0; blackShuai.col = 4;blackShuai.isDead = false
        blackShi1.row = 0; blackShi1.col = 3;blackShi1.isDead = false
        blackShi2.row = 0; blackShi2.col = 5;blackShi2.isDead = false
        blackEle1.row = 0; blackEle1.col = 2;blackEle1.isDead = false
        blackEle2.row = 0; blackEle2.col = 6;blackEle2.isDead = false
        blackHorse1.row = 0; blackHorse1.col = 1;blackHorse1.isDead = false
        blackHorse2.row = 0; blackHorse2.col = 7;blackHorse2.isDead = false
        blackCar1.row = 0; blackCar1.col = 0;blackCar1.isDead = false
        blackCar2.row = 0; blackCar2.col = 8;blackCar2.isDead = false
        blackGun1.row = 2; blackGun1.col = 1;blackGun1.isDead = false
        blackGun2.row = 2; blackGun2.col = 7;blackGun2.isDead = false
        blackBing1.row = 3; blackBing1.col = 0;blackBing1.isDead = false
        blackBing2.row = 3; blackBing2.col = 2;blackBing2.isDead = false
        blackBing3.row = 3; blackBing3.col = 4;blackBing3.isDead = false
        blackBing4.row = 3; blackBing4.col = 6;blackBing4.isDead = false
        blackBing5.row = 3; blackBing5.col = 8;blackBing5.isDead = false
        //init RedChess
        redShuai.row = 9; redShuai.col = 4;redShuai.isDead = false
        redShi1.row = 9; redShi1.col = 3;redShi1.isDead = false
        redShi2.row = 9; redShi2.col = 5;redShi2.isDead = false
        redEle1.row = 9; redEle1.col = 2;redEle1.isDead = false
        redEle2.row = 9; redEle2.col = 6;redEle2.isDead = false
        redHorse1.row = 9; redHorse1.col = 1;redHorse1.isDead = false
        redHorse2.row = 9; redHorse2.col = 7;redHorse2.isDead = false
        redCar1.row = 9; redCar1.col = 0;redCar1.isDead = false
        redCar2.row = 9; redCar2.col = 8;redCar2.isDead = false
        redGun1.row = 7; redGun1.col = 1;redGun1.isDead = false
        redGun2.row = 7; redGun2.col = 7;redGun2.isDead = false
        redBing1.row = 6; redBing1.col = 0;redBing1.isDead = false
        redBing2.row = 6; redBing2.col = 2;redBing2.isDead = false
        redBing3.row = 6; redBing3.col = 4;redBing3.isDead = false
        redBing4.row = 6; redBing4.col = 6;redBing4.isDead = false
        redBing5.row = 6; redBing5.col = 8;redBing5.isDead = false
    }
//通过类型和阵营寻找棋子
    function getID1(index,camp) {
        if( blackShuai.index ===index && blackShuai.camp ===camp) { return blackShuai }
        else if( blackShi1.index ===index && blackShi1.camp ===camp) { return blackShi1 }
        else if( blackShi2.index ===index && blackShi2.camp ===camp) { return blackShi2 }
        else if( blackEle1.index ===index && blackEle1.camp ===camp) { return blackEle1 }
        else if( blackEle2.index ===index && blackEle2.camp ===camp) { return blackEle2 }
        else if( blackHorse1.index ===index && blackHorse1.camp ===camp) { return blackHorse1 }
        else if( blackHorse2.index ===index && blackHorse2.camp ===camp) { return blackHorse2 }
        else if( blackCar1.index ===index && blackCar1.camp ===camp ) { return blackCar1 }
        else if( blackCar2.index ===index && blackCar2.camp ===camp ) { return blackCar2 }
        else if( blackGun1.index ===index && blackGun1.camp ===camp ) { return blackGun1 }
        else if( blackGun2.index ===index && blackGun2.camp ===camp ) { return blackGun2 }
        else if( blackBing1.index ===index && blackBing1.camp ===camp ) { return blackBing1 }
        else if( blackBing2.index ===index && blackBing2.camp ===camp ) { return blackBing2 }
        else if( blackBing3.index ===index && blackBing3.camp ===camp ) { return blackBing3 }
        else if( blackBing4.index ===index && blackBing4.camp ===camp ) { return blackBing4 }
        else if( blackBing5.index ===index && blackBing5.camp ===camp ) { return blackBing5 }

        else if( redShuai.index ===index && redShuai.camp ===camp ) { return redShuai }
        else if( redShi1.index ===index && redShi1.camp ===camp) { return redShi1}
        else if( redShi2.index ===index && redShi2.camp ===camp) { return redShi2 }
        else if( redEle1.index ===index && redEle1.camp ===camp) { return redEle1 }
        else if( redEle2.index ===index && redEle2.camp ===camp) { return redEle2 }
        else if( redHorse1.index ===index && redHorse1.camp ===camp ) { return redHorse1 }
        else if( redHorse2.index ===index && redHorse2.camp ===camp ) { return redHorse2 }
        else if( redCar1.index ===index && redCar1.camp ===camp) { return redCar1 }
        else if( redCar2.index ===index && redCar2.camp ===camp) { return redCar2 }
        else if( redGun1.index ===index && redGun1.camp ===camp) { return redGun1 }
        else if( redGun2.index ===index && redGun2.camp ===camp) { return redGun2 }
        else if( redBing1.index ===index && redBing1.camp ===camp ) { return redBing1 }
        else if( redBing2.index ===index && redBing2.camp ===camp ) { return redBing2 }
        else if( redBing3.index ===index && redBing3.camp ===camp ) { return redBing3 }
        else if( redBing4.index ===index && redBing4.camp ===camp ) { return redBing4 }
        else if( redBing5.index ===index && redBing5.camp ===camp) { return redBing5 }
        else return null
    }
//通过行和列来判断棋子的类型
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
