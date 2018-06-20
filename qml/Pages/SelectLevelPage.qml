import QtQuick 2.9
import QtQuick.Controls 2.2

import CppItems 0.1 as CppItems

import ".."

BasePage {
    id: root
    name: ""

    signal selectLevel(CppItems.Level level)

    function update(id, state){
        if(id < applicationSettings.levelsCount()){
            gridListModel.get(id).open = state
        }
    }

    ListModel {
        id: gridListModel
    }

    Component {
        id: gridDelegate

        Item {
            id: gridDelegateItem

            property bool activated: model.open === true ? true : false
//            property bool activated: true

            Loader {
                id: levelLoader
                source: "qrc:/qml/Levels/Level_" + model.id + ".qml"
            }

            width: Utils.percent(25, root.width - (4 * selectLevelGrid.spacing) - (2 * selectLevelGrid.anchors.leftMargin))
            height: Utils.percent(15, (root.height - pageHeader.height - pageFooter.height) - (6 * selectLevelGrid.spacing) - (2 * selectLevelGrid.anchors.topMargin))

            Image {
                sourceSize.height: parent.height
                sourceSize.width: parent.width
                source: gridDelegateItem.activated ? "qrc:/assets/svg/design/openedLevelIcon.svg" : "qrc:/assets/svg/design/closedLevelIcon.svg"

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: parent.width / 2
                    font.family: Style.fontFamily
                    color: Style.fontColor
                    text: gridDelegateItem.activated ? model.id + 1 : ""
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: if(gridDelegateItem.activated) selectLevel(levelLoader.item)
            }
        }
    }

    Grid {
        id: selectLevelGrid
        anchors.left: parent.left
        anchors.leftMargin: Utils.percent(5, root.width)
        anchors.right: parent.right
        anchors.rightMargin: anchors.leftMargin
        anchors.top: pageHeader.bottom
        anchors.topMargin: anchors.leftMargin
        anchors.bottom: pageFooter.bottom
        anchors.bottomMargin: anchors.leftMargin

        spacing: 10

        Repeater {
            model: gridListModel
            delegate: gridDelegate
        }
    }

    Component.onCompleted: {
        gridListModel.clear()
        for(var i = 0; i < applicationSettings.levelsCount(); i++){
            gridListModel.append({
                "id": applicationSettings.levelId(i),
                "open": applicationSettings.levelOpened(i)
            });
        }
    }
}
