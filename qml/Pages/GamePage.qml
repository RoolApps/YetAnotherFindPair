import QtQuick 2.9
import QtMultimedia 5.9

import CppItems 0.1 as CppItems
import ".."

BasePage {
    id: root
    name: ""

    function loadLevel(level){
        gamePlane.loadLevel(level)
    }

    signal newLevelOpened(CppItems.GameResult result)
    signal goHome()

    SoundEffect {
        id: soundEffect
        volume: 0.2
        source: "qrc:/assets/sound/move.wav"
    }

    Item {
        id: restartButton
        anchors.top: pageHeader.top
        anchors.topMargin: height / 2
        anchors.left: pageHeader.left
        anchors.leftMargin: (pageHeader.width / 2) - (width / 2)
        width: Style.pageHeaderHeight
        height: width

        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "qrc:/assets/svg/design/restartButton.svg"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: gamePlane.restartLevel()
        }
    }

    Item {
        id: homeButton
        anchors.top: pageHeader.top
        anchors.topMargin: height / 2
        anchors.right: pageHeader.right
        anchors.rightMargin: width / 2
        width: Style.pageHeaderHeight
        height: width

        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "qrc:/assets/svg/design/homeButton.svg"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: root.goHome()
        }
    }

    CppItems.GamePlane {
        id: gamePlane
        anchors.top: pageHeader.bottom
        anchors.bottom: pageFooter.top
        anchors.left: parent.left
        anchors.right: parent.right

        foregroundGrid: CppGrid {
            anchors.centerIn: parent
        }

        onNewLevelOpened: root.newLevelOpened(result)
        onSoundEffect: if(applicationSettings.slideEffectSound()) soundEffect.play()
    }
}
