import QtQuick 2.9
import QtQuick.Controls 2.2

import ".."

Item {
    id: root

    width: Style.menuPageButtonWidth
    height: Style.menuPageButtonHeight

    anchors.horizontalCenter: parent.horizontalCenter

    property alias text: textField.text

    signal clicked()

    Image {
        id: container
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        source: "qrc:/assets/svg/design/menuButtonContainer.svg"

        Text {
            id: textField
            anchors.centerIn: parent
            color: Style.fontColor
            font.family: Style.fontFamily
            font.pointSize: 48
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            animation.start()
            root.clicked()
        }
    }

    NumberAnimation {
        id: animation
        target: textField
        properties: "opacity"
        to: 0.5
        duration: 500

        onStopped: textField.opacity = 1
    }
}
