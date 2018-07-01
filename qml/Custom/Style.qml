pragma Singleton

import QtQuick 2.9
import QtQuick.Window 2.3

import "../../Utils.js" as Utils

Item {
    // Screen
    //readonly property int screenHeight: Screen.height
    //readonly property int screenWidth: Screen.width
    readonly property int screenHeight: 960
    readonly property int screenWidth: 540
    // Android
    readonly property string androidBackgroundColor: "#ffc9f2fc"
    // All
    readonly property string fontFamily: "Arial"
    readonly property string fontColor: "#ffffffff"
    // Pages
    readonly property int pageHeaderHeight: Utils.percent(8, screenHeight)
    readonly property int pageFooterHeight: Utils.percent(10, screenHeight)
    readonly property string pageHeaderTitleFontFamily: fontFamily
    readonly property int pageHeaderTitleFontSize: Utils.percent(55, pageHeaderHeight)
    readonly property string pageHeaderTitleFontColor: fontColor
    // GamePage
    readonly property int gamePageTimerHeight: Utils.percent(8, screenHeight)
    readonly property string gamePageTimerFontFamily: fontFamily
    readonly property int gamePageLeftMargin: Utils.percent(10, screenWidth)
    readonly property int gamePageRightMargin: Utils.percent(10, screenWidth)
    readonly property int gamePageTopMargin: Utils.percent(7, screenHeight)
    readonly property int gamePageBottomMargin: Utils.percent(7, screenHeight)
    // MenuPage
    readonly property int menuPageButtonHeight: Utils.percent(10, screenHeight)
    readonly property int menuPageButtonWidth: Utils.percent(60, screenWidth)
    readonly property string menuPageFontColor: "#4d4a69"
    // SettingsPage
    readonly property int settingsPageButtonHeight: Utils.percent(10, screenHeight)
    readonly property string settingsPageCheckBoxColor: "#ff3f4f5f"
    // AboutPage
    readonly property int aboutPageTextSize: Utils.percent(1, screenHeight)
    readonly property int aboutPageTextSizeH1: aboutPageTextSize + 2
}

