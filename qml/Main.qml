//Author:yangyunbo
//Date:2023.6.15
//Function:every scene switch
import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtMultimedia 5.0

import "scenes"
import "dialogs"

GameWindow {
    id: gameWindow
    screenWidth: 640
    screenHeight: 960

    EntityManager {
        id: entityManager
    }
    FontLoader {
        id: standardFont
        source: "../assets/fonts/bubblegum.ttf"
    }

    MenuScene{
        id:menuScene
        onBeginOwnPlay: gameWindow.state = "play"
        onBeginAIPlay: gameWindow.state = "playAI"
        onBeginDoublePlay: gameWindow.state = "network"
        onBackButtonPressed: gameWindow.state ="main"
    }

    HelpScene{
        id:helpScene
        onBackButtonPressed: gameWindow.state ="main"
    }


    MainScene{
        id:mainScene

        onBeginGamePressed: gameWindow.state = "menu"
        onHelpGamePressed: gameWindow.state = "help"
        onSetGamePressed: gameWindow.state = "set"

    }

    SettingScene{
        id:settingScene
        onBackButtonPressed: gameWindow.state ="main"
    }

    PlayScene{
        id:playScene
        onBackButtonPressed: gameWindow.state ="menu"
    }

    PlayAiScene{
        id:playAiScene
    }

    PlayDoubleScene{
        id:playDoubleScene
    }

    LocalMenuScene{
        id:localMenuScene
        onBackButtonPressed: gameWindow.state = "menu"
        onCreateRoom: gameWindow.state = "create"
        onJoinRoom: gameWindow.state = "join"
    }

    CreateRoomScene {
        id:createRoomScene
        onBackButtonPressed: gameWindow.state = "network"
        onGamePressed: {
            gameWindow.state = "playDouble"
            playDoubleScene.isConnected = true
        }
    }

    JoinRoomScene {
        id:joinRoomScene
        onBackButtonPressed: gameWindow.state = "network"
        onGamePressed: {
            gameWindow.state = "playDouble"

            playDoubleScene.isConnected = true
        }
    }

    state: "main"

    states:[
        State{
            name:"main"
            PropertyChanges {
                target: mainScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:mainScene
            }
        },
        State{
            name:"menu"
            PropertyChanges {
                target: menuScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:menuScene
            }
        },
        State{
            name:"help"
            PropertyChanges {
                target: helpScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:helpScene
            }
        },
        State{
            name:"set"
            PropertyChanges {
                target: settingScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:settingScene
            }
        },
        State{
            name:"play"
            PropertyChanges {
                target: playScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:playScene
            }
        },
        State{
            name:"playAI"
            PropertyChanges {
                target: playAiScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:playAiScene
            }
        },
        State{
            name:"playDouble"
            PropertyChanges {
                target: playDoubleScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:playDoubleScene
            }
        },
        State{
            name:"network"
            PropertyChanges {
                target: localMenuScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:localMenuScene
            }
        },
        State{
            name:"create"
            PropertyChanges {
                target: createRoomScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:createRoomScene
            }
        },
        State{
            name:"join"
            PropertyChanges {
                target: joinRoomScene;
                opacity:1
            }
            PropertyChanges {
                target: gameWindow;
                activeScene:joinRoomScene
            }
        }
    ]

    //    // background music
    //    BackgroundMusic {
    //      volume: 0.20
    //      id: ambienceMusic
    //      source: "../../..."
    //    }

    MediaPlayer{
        id:musicPlayer
        source: "../assets/audio/BG.mp3"
        volume: 0.5
        autoPlay: false
        loops:MediaPlayer.Infinite
    }

    // timer plays the background music
    Timer {
        id: timerMusic
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            musicPlayer.play()
            running = false
        }
    }
}
