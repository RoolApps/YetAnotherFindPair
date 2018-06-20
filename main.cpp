#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QSettings>

#include "QtAdMob/QtAdMobBanner.h"
#include "QtAdMob/QtAdMobInterstitial.h"

#include "game.h"
#include "level.h"
#include "settings.h"
#include "gameplane.h"
#include "gameresult.h"

QString appPath;

int main(int argc, char *argv[]){
    QGuiApplication app(argc, argv);
    appPath = app.applicationDirPath();

    app.setOrganizationName(GAME_ORGANIZATION);
    app.setApplicationName(GAME_NAME);

    QmlAdMobBanner::DeclareQML();
    QmlAdMobInterstitial::DeclareQML();

    qmlRegisterType<Game>("CppItems", 0, 1, "Game");
    qmlRegisterType<GamePlane>("CppItems", 0, 1, "GamePlane");
    qmlRegisterType<Level>("CppItems", 0, 1, "Level");
    qmlRegisterType<GameResult>("CppItems", 0, 1, "GameResult");

    QQmlApplicationEngine engine;

    Game::setEngine(&engine);

    Settings settings;

    engine.rootContext()->setContextProperty("applicationPath", appPath);
    engine.rootContext()->setContextProperty("applicationSettings", &settings);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
