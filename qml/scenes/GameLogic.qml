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
    function setChessPos(x,y,cp,id){
        lastX = x
        lastY = y
        camp =cp
        index = id
        console.log("ChooseX: "+lastX+" ChooseY: "+lastY+" camp: "+camp+" index: "+index)
    }

    function getChoosePos(mouseX,mouseY){
        newCol = (mouseX+34)/68
        newRow = (mouseY+34)/68
        console.log("newRow: "+newRow+"  newCol: "+newCol)
        if(mouseCount == 0 && getID(newRow,newCol)===null){
            newCol =-1
            newRow =-1
        }
        else mouseCount++
        console.log(getID(newRow,newCol))
        console.log(mouseCount)
        if(mouseCount === 1 ){
            lastRow = newRow
            lastCol = newCol
            camp = getID(newRow,newCol).camp
        }
        else if(mouseCount === 2 && getID(newRow,newCol)!==null){
            if(getID(newRow,newCol).camp===camp)
            {
                mouseCount--
                lastRow = newRow
                lastCol = newCol
            }
            else{
                mouseCount =0
                eatChess(lastRow,lastCol,newRow,newCol)
            }
        }
        else if(mouseCount === 2){
            mouseCount =0
            updateChessPos(lastRow,lastCol,newRow,newCol)
        }
    }

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
        console.log(canMove)
        if(canMove){
            move.start()
        }
        //        else {

        //        }
    }

    function eatChess(lastRow,lastCol,newRow,newCol){
//        move.start()
        updateChessPos(lastRow,lastCol,newRow,newCol)
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
        else return true
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
            console.log(lineLength)
            if(lineLength<0){
                for(var i =newX+1;i<lastX;i++){
                    if(getID(newY,i)!==null)
                        lineCount++
                }
                console.log(lineCount)
                return lineCount
            }else{
                for(var j =lastX+1;j<newX;j++){
                    if(getID(newY,j)!==null)
                        lineCount++
                }
                console.log(lineCount)
                return lineCount
            }
        }else if(newX===lastX){
            lineLength = newY-lastY
            console.log(lineLength)
            if(lineLength<0){
                for(var a =newY+1;a<lastY;a++){
                    console.log(a+"    "+ newX)
                    if(getID(a,newX)!==null)
                        lineCount++
                }
                console.log(lineCount)
                return lineCount
            }else{
                for(var b =lastY+1;b<newY;b++){
                    console.log(b+"    "+ newX)
                    if(getID(b,newX)!==null)
                        lineCount++
                }
                console.log(lineCount)
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
        PropertyAnimation{
            target:getID(lastRow,lastCol)
            property: "row"
            to:newRow
            duration: 100
        }
        PropertyAnimation{
            target:getID(lastRow,lastCol)
            property: "col"
            to:newCol
            duration: 100
        }
    }

    function initGame(){
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
        if( blackShuai.row ===row && blackShuai.col ===col ) { return blackShuai }
        else if( blackShi1.row ===row && blackShi1.col ===col ) { return blackShi1 }
        else if( blackShi2.row ===row && blackShi2.col ===col ) { return blackShi2 }
        else if( blackEle1.row ===row && blackEle1.col ===col ) { return blackEle1 }
        else if( blackEle2.row ===row && blackEle2.col ===col ) { return blackEle2 }
        else if( blackHorse1.row ===row && blackHorse1.col ===col ) { return blackHorse1 }
        else if( blackHorse2.row ===row && blackHorse2.col ===col ) { return blackHorse2 }
        else if( blackCar1.row ===row && blackCar1.col ===col ) { return blackCar1 }
        else if( blackCar2.row ===row && blackCar2.col ===col ) { return blackCar2 }
        else if( blackGun1.row ===row && blackGun1.col ===col ) { return blackGun1 }
        else if( blackGun2.row ===row && blackGun2.col ===col ) { return blackGun2 }
        else if( blackBing1.row ===row && blackBing1.col ===col ) { return blackBing1 }
        else if( blackBing2.row ===row && blackBing2.col ===col ) { return blackBing2 }
        else if( blackBing3.row ===row && blackBing3.col ===col ) { return blackBing3 }
        else if( blackBing4.row ===row && blackBing4.col ===col ) { return blackBing4 }
        else if( blackBing5.row ===row && blackBing5.col ===col ) { return blackBing5 }

        else if( redShuai.row ===row && redShuai.col ===col ) { return redShuai }
        else if( redShi1.row ===row && redShi1.col ===col ) { return redShi1}
        else if( redShi2.row ===row && redShi2.col ===col ) { return redShi2 }
        else if( redEle1.row ===row && redEle1.col ===col ) { return redEle1 }
        else if( redEle2.row ===row && redEle2.col ===col ) { return redEle2 }
        else if( redHorse1.row ===row && redHorse1.col ===col ) { return redHorse1 }
        else if( redHorse2.row ===row && redHorse2.col ===col ) { return redHorse2 }
        else if( redCar1.row ===row && redCar1.col ===col ) { return redCar1 }
        else if( redCar2.row ===row && redCar2.col ===col ) { return redCar2 }
        else if( redGun1.row ===row && redGun1.col ===col ) { return redGun1 }
        else if( redGun2.row ===row && redGun2.col ===col ) { return redGun2 }
        else if( redBing1.row ===row && redBing1.col ===col ) { return redBing1 }
        else if( redBing2.row ===row && redBing2.col ===col ) { return redBing2 }
        else if( redBing3.row ===row && redBing3.col ===col ) { return redBing3 }
        else if( redBing4.row ===row && redBing4.col ===col ) { return redBing4 }
        else if( redBing5.row ===row && redBing5.col ===col ) { return redBing5 }
        else return null
    }
}
