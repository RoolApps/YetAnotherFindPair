import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9

import com.dreamdev.QtAdMobBanner 1.0
import com.dreamdev.QtAdMobInterstitial 1.0

import CppItems 0.1 as CppItems

import ".."

Item {
    Rectangle {
        id: background
        anchors.fill: parent
        color: Style.androidBackgroundColor
    }

    Audio {
        id: backgroudMusic
        loops: SoundEffect.Infinite
        volume: 0.2
        source: "qrc:/assets/sound/background.mp3"
    }

    StackView {
        id: navigation
        anchors.fill: parent
        initialItem: menuPage
        focus: true

        MenuPage {
            id: menuPage
            opacity: 1

            onPlayButtonClicked: navigation.push(selectLevelPage)
            onSettingsButtonClicked: navigation.push(settingsPage)
            onTutorialButtonClicked: navigation.push(tutorialPage)
        }

        SettingsPage {
            id: settingsPage
            x: -parent.width

            onBackButtonClicked: navigation.pop()
            onMusicStateChanged: {
                if(state) backgroudMusic.play()
                else backgroudMusic.stop()
            }
        }

        SelectLevelPage {
            id: selectLevelPage
            x: -parent.width

            onBackButtonClicked: navigation.pop()
            onSelectLevel: {
                navigation.push(gamePage)
                gamePage.loadLevel(level)
            }
        }

        GamePage {
            id: gamePage
            x: -parent.width

            onBackButtonClicked: navigation.pop(selectLevelPage)
            onNewLevelOpened: {
                if (intertitial.isLoaded && result.levelId % 3) intertitial.visible = true
                selectLevelPage.update(result.levelId, true)
                navigation.push(resultPage)
                resultPage.loadResult(result)
            }
            onGoHome: navigation.pop(null)
        }

        ResultPage {
            id: resultPage
            x: -parent.width

            onStartNextLevel: {
                navigation.pop(gamePage)
                gamePage.loadLevel(level)
            }
            onStartPreviousLevel: {
                navigation.pop(gamePage)
                gamePage.loadLevel(level)
            }
            onGoHome: navigation.pop(null)
        }

        TutorialPage {
            id: tutorialPage
            x: -parent.width

            onBackButtonClicked: navigation.pop()
        }

        Keys.onBackPressed: {
            if(navigation.depth > 1){
                if(navigation.currentItem != resultPage){
                    navigation.pop()
                }else {
                    navigation.pop(selectLevelPage)
                }

                event.accepted = true
            }else {
                Qt.quit()
            }
        }

        pushExit: exitTransition
        pushEnter: enterTransition
        popExit: exitTransition
        popEnter: enterTransition

        Transition {
            id: exitTransition
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 500
                easing.type: Easing.OutQuad
            }
        }

        Transition {
            id: enterTransition
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.OutQuad
            }
        }
    }

    AdMobBanner {
        id: banner

        Component.onCompleted: {
            banner.unitId = "ca-app-pub-1760789437352089/2252532558"
            banner.size = AdMobBanner.SmartBanner
            banner.visible = true
        }

        onLoaded: banner.y = root.height - banner.height
    }

    AdMobInterstitial {
        id: intertitial

        Component.onCompleted: {
            intertitial.unitId = "ca-app-pub-1760789437352089/5620931921"
        }

        onClosed: {
            intertitial.unitId = "ca-app-pub-1760789437352089/5620931921"
        }
    }

    Component.onCompleted: {
        if(applicationSettings.backgroundMusic()) backgroudMusic.play()
    }

    Connections {
        target: Qt.application
        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationActive) {
                if(applicationSettings.backgroundMusic()) backgroudMusic.play()
            }else if(Qt.application.state === Qt.ApplicationInactive){
                backgroudMusic.pause()
            }
        }
    }
}
