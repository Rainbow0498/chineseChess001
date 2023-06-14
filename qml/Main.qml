import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0

import "scenes"
GameWindow {
    id: gameWindow
    screenWidth: 540
    screenHeight: 960

    EntityManager {
      id: entityManager
    }
    FontLoader {
      id: standardFont
      source: "fonts/bubblegum.ttf"
    }

    SetScene{

    }
}
