pragma Singleton

import QtQuick 2.9
import QtQuick.Window 2.3

import "../../Utils.js" as Utils

Item {
    // Android
    readonly property string androidBackgroundColor: "#ffc9f2fc"
    // All
    readonly property string fontFamily: "Comic Sans MS"
    readonly property string fontColor: "#ffffffff"
    // Pages
    readonly property int pageHeaderHeight: Utils.percent(8, Screen.height)
    readonly property int pageFooterHeight: Utils.percent(10, Screen.height)
    readonly property string pageHeaderTitleFontFamily: fontFamily
    readonly property int pageHeaderTitleFontSize: Utils.percent(55, pageHeaderHeight)
    readonly property string pageHeaderTitleFontColor: fontColor
    // MenuPage
    readonly property int menuPageButtonHeight: Utils.percent(10, Screen.height)
    readonly property int menuPageButtonWidth: Utils.percent(60, Screen.width)
    // SettingsPage
    readonly property int settingsPageButtonHeight: Utils.percent(10, Screen.height)
    readonly property string settingsPageCheckBoxColor: "#ff27a1c3"
    // AboutPage
    readonly property int aboutPageTextSize: Utils.percent(1, Screen.height)
    readonly property int aboutPageTextSizeH1: aboutPageTextSize + 2
}

