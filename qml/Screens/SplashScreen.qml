import QtQuick 2.9
import QtQuick.Window 2.3

Rectangle {
    id: root

    function hide() {
        animation.start()
    }

    Image {
        id: background
        sourceSize.width: Screen.width
        sourceSize.height: Screen.height
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/svg/design/splashBackground.svg"
    }

    NumberAnimation {
        id: animation
        running: false
        target: root
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 1000

        onRunningChanged: if (!running) root.destroy();
    }
}
