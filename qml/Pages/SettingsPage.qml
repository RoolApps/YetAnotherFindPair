import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9

import ".."

BasePage {
    id: root
    name: ""

    signal musicStateChanged(bool state)
    signal effectsStateChanged(bool state)

    SoundEffect {
        id: soundEffect
        volume: 0.2
        source: "qrc:/assets/sound/move.wav"
    }

    ColumnLayout {
        anchors.centerIn: parent
        layoutDirection: Qt.RightToLeft

        SettingsPageButton {
            id: musicButton
            text: "Music"
            activated: applicationSettings.backgroundMusic()

            onStateChanged: {
                applicationSettings.setBackgroundMusic(state)
                root.musicStateChanged(state)
            }
        }

        SettingsPageButton {
            id: effectsButton
            text: "Effects"
            activated: applicationSettings.slideEffectSound()

            onStateChanged: {
                if(state) soundEffect.play()
                applicationSettings.setSlideEffectSound(state)
                root.effectsStateChanged(state)
            }
        }
    }
}
