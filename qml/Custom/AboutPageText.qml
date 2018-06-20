import QtQuick 2.9

import ".."

Item {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 15
    anchors.rightMargin: 15

    implicitHeight: txt.implicitHeight

    property alias text: txt.text
    property alias textSize: txt.font.pointSize

    Text {
        id: txt
        anchors.fill: parent
        wrapMode: Text.WordWrap
        font.family: Style.fontFamily
        font.pointSize: Style.aboutPageTextSize
        color: Style.fontColor
        horizontalAlignment:Text.AlignHCenter
    }
}
