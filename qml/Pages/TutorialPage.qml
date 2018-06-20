import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

import ".."

BasePage {
    id: root
    name: ""

    Image {
        anchors.centerIn: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        sourceSize.width: Screen.width
        sourceSize.height: Screen.height - Style.pageHeaderHeight - Style.pageFooterHeight

        source: "qrc:/assets/svg/design/aboutPageBackground.svg"
    }
}
