import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0
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
        onBackButtonPressed: gameWindow.state ="main"
    }

    HelpScene{
        id:helpScene
        onBackButtonPressed: gameWindow.state ="main"
    }

    MainScene{
        id:mainScene

        onBeginGamePressed: gameWindow.state = "menu"
//        onBeginGamePressed:gameWindow.state = "menu"
//        onCloseGamePressed: gameWindow.state = "close"
        onHelpGamePressed: gameWindow.state = "help"
        onSetGamePressed: gameWindow.state = "set"

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
        }
    ]
}
