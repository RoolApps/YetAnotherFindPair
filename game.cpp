#include "game.h"

QQmlEngine * Game::c_engine = nullptr;

/*ctor*/
Game::Game(QObject *parent) : QObject(parent){

}

/*public*/
QQmlEngine * Game::engine(){
    return Game::c_engine;
}

void Game::setEngine(QQmlEngine *engine){
    if(Game::c_engine != engine){
        Game::c_engine = engine;
    }
}

QQuickItem * Game::createQmlObject(QString const name){
    QQmlComponent component(Game::engine(), QUrl("qrc:/qml/Cpp/" + name + ".qml"));
    QQuickItem * qmlComponent = qobject_cast<QQuickItem *>(component.create());
    return qmlComponent;
}

QString Game::cellTypeAsString(CellType type){
    QString stype = staticMetaObject.enumerator(staticMetaObject.indexOfEnumerator("CellType")).valueToKey(type);
    dbg << type << stype;
    return stype;
}

QString Game::fullImagePath(CellType type){
    if (type == Game::CellType::Transparent) {
        return QString("qrc:/assets/svg/Icons/_Transparent.svg");
    }
    else {
        return QString("qrc:/assets/svg/Icons/" + cellTypeAsString(type) + ".svg");
    }
}

QString Game::fullFrontImagePath(CellType type){
    if (type == Game::CellType::Transparent) {
        return QString("qrc:/assets/svg/Icons/_Transparent.svg");
    }
    else {
        return QString("qrc:/assets/svg/Icons/_Hidden.svg");
    }
}
