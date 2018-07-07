import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2

import "."

ApplicationWindow {
    id: root
    //visibility: Window.FullScreen
    x: 1000; y: 40;
    width: Style.screenWidth; height: Style.screenHeight;
    visible: true

    Loader {
        id: gameLoader
        anchors.fill: parent
        asynchronous: true
        focus: true

        onStatusChanged: {
            if(status == Loader.Ready){
                splashScreen.hide()
                visible = true
            }
        }
    }

    SplashScreen {
        id: splashScreen
        anchors.fill: parent
        Component.onCompleted: gameLoader.source = "qrc:/qml/Screens/MainScreen.qml"
    }
}
