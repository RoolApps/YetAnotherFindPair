import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import ".."

Item {
    id: root

    height: Style.settingsPageButtonHeight
    implicitWidth: rowLayout.implicitWidth

//    anchors.horizontalCenter: parent.horizontalCenter

    property alias text: textField.text
    property alias activated: checkbox.checked

    signal stateChanged(bool state)

    RowLayout {
        id: rowLayout
        spacing: textField.height

        Text {
            id: textField
            font.family: Style.fontFamily
            font.pointSize: 48
            color: Style.fontColor
            anchors.verticalCenter: parent.verticalCenter
        }

        CheckBox {
            id: checkbox

            indicator: Rectangle {
                implicitWidth: textField.height
                implicitHeight: textField.height
                radius: 5
                border.color: Style.settingsPageCheckBoxColor

                Rectangle {
                    width: parent.width / 2
                    height: parent.height / 2
                    anchors.centerIn: parent
                    radius: 2
                    color: Style.settingsPageCheckBoxColor
                    visible: checkbox.checked
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            checkbox.checked = !checkbox.checked
            root.stateChanged(checkbox.checked)
        }
    }
}
