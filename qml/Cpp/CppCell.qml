import QtQuick 2.0
import QtMultimedia 5.9

Flipable {
    id: root

    property bool flipped: false
    property alias source: image.source
    property alias frontSource: frontImage.source

    signal animationStopped();
    signal clicked();
    signal rotationStopped();

    back: Image {
        id: image
        objectName: "image"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
    }
    front: Image {
        id: frontImage
        objectName: "frontImage"
        source: "qrc:/assets/svg/Icons/_Hidden.svg"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectFit
    }

    transform: Rotation {
        id: rotation
        origin.x: root.width / 2
        origin.y: root.height / 2
        axis.x: 0
        axis.y: 1
        axis.z: 0
        angle: 0
    }

    states: State {
        id: state
        name: "back"
        PropertyChanges {
            target: rotation
            angle: 180
        }
        when: root.flipped
    }

    transitions: Transition {

        NumberAnimation {
            target: rotation
            property: "angle"
            duration: 500
        }
        onRunningChanged: {

            if(!running) {
                rotationStopped();
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
    }

    Behavior on x {
        NumberAnimation {
            id: numberAnimationX
            easing.overshoot: 0.5
            easing.period: 0.5
            easing.amplitude: 1
            easing.type: Easing.InOutSine
            duration: 250

            onRunningChanged: if(!running) animationStopped()
        }
    }

    Behavior on y {
        NumberAnimation {
            id: numberAnimationY
            easing.overshoot: 0.5
            easing.period: 0.5
            easing.amplitude: 1
            easing.type: Easing.InOutSine
            duration: 250

            onRunningChanged: if(!running) animationStopped()
        }
    }
}
