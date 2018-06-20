import QtQuick 2.0

Grid {
    id: grid
    objectName: "grid"
    spacing: 10

    add: Transition {
        NumberAnimation {
            duration: 500
        }
    }
}
