import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import ".."

BasePage {
    id: root
    withBackButton: false

    signal playButtonClicked()
    signal tutorialButtonClicked()
    signal settingsButtonClicked()

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 35

        MenuPageButton {
            text: "Play"

            onClicked: root.playButtonClicked()
        }

        MenuPageButton {
            text: "Settings"

            onClicked: root.settingsButtonClicked()
        }

        MenuPageButton {
            text: "About"

            onClicked: root.tutorialButtonClicked()
        }

        MenuPageButton {
            text: "Exit"

            onClicked: Qt.quit()
        }
    }
}
