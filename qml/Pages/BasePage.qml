import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

import ".."

Page {
    id: root

    opacity: 0

    property Item pageHeader: header
    property Item pageFooter: footer

    property alias name: titleText.text

    property bool withBackButton: true

    signal backButtonClicked()

    Image {
        id: background
        sourceSize.width: Screen.width
        sourceSize.height: Screen.height
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/svg/design/background.svg"
    }

    Rectangle {
        id: header

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Style.pageHeaderHeight + (backButton.height / 2)

        visible: withBackButton
        enabled: withBackButton
        color: "transparent"

        RowLayout {
            anchors.fill: parent

            Item {
                id: backButton
                anchors.top: parent.top
                anchors.topMargin: height / 2
                anchors.left: parent.left
                anchors.leftMargin: width / 2
                width: Style.pageHeaderHeight
                height: width

                Image {
                    sourceSize.width: parent.width
                    sourceSize.height: parent.height
                    source: "qrc:/assets/svg/design/backButton.svg"
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: root.backButtonClicked()
                }
            }

            Text {
                id: titleText
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.family: Style.pageHeaderTitleFontFamily
                font.pointSize: Style.pageHeaderTitleFontSize
                color: Style.pageHeaderTitleFontColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
            }
        }
    }

    Rectangle {
        id: footer

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: Style.pageFooterHeight

        color: "transparent"
    }
}
