import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

import ".."
import CppItems 0.1 as CppItems

BasePage {
    id: root
    name: ""
    withBackButton: false

    signal startNextLevel(CppItems.Level level)
    signal startPreviousLevel(CppItems.Level level)
    signal goHome()

    property alias levelId: levelIdTxt.text
    property alias moves: movesTxt.text
    property alias time: timeTxt.text

    onLevelIdChanged: {
        var previousLevelSource = "qrc:/qml/Levels/Level_" + (levelId - 1) + ".qml"
        if(levelId < applicationSettings.levelsCount()){
            nextLevelLoader.source = "qrc:/qml/Levels/Level_" + levelId + ".qml"
        }else {
            nextLevelLoader.source = previousLevelSource
        }
        previousLevelLoader.source = previousLevelSource
    }

    function loadResult(result){
        levelId = result.levelId
        moves = result.moves
        time = result.time
    }

    Loader {
        id: nextLevelLoader
    }

    Loader {
        id: previousLevelLoader
    }

    Image {
        id: background
        sourceSize.width: Screen.width
        sourceSize.height: Screen.height
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/svg/design/resultBackground.svg"
    }

    Item {
        id: homeButton
        anchors.top: parent.top
        anchors.topMargin: height / 2
        anchors.left: parent.left
        anchors.leftMargin: width / 2
        width: Style.pageHeaderHeight
        height: width

        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "qrc:/assets/svg/design/homeButton.svg"
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: false

            onClicked: root.goHome()
        }
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

            onClicked: {
                if(previousLevelLoader.status == Loader.Ready){
                    root.startPreviousLevel(previousLevelLoader.item)
                }
            }
        }
    }

    Item {
        id: nextButton
        anchors.top: pageHeader.top
        anchors.topMargin: height / 2
        anchors.right: pageHeader.right
        anchors.rightMargin: width / 2
        width: Style.pageHeaderHeight
        height: width

        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "qrc:/assets/svg/design/nextButton.svg"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if(nextLevelLoader.status == Loader.Ready){
                    root.startNextLevel(nextLevelLoader.item)
                }
            }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent

        RowLayout {
            ResultPageText {
                text: "Level:  "
            }

            ResultPageText {
                id: levelIdTxt
            }
        }

        RowLayout {
            ResultPageText {
                text: "Time:   "
            }

            ResultPageText {
                id: timeTxt
            }
        }

        RowLayout {
            ResultPageText {
                text: "Moves: "
            }

            ResultPageText {
                id: movesTxt
            }
        }
    }
}
