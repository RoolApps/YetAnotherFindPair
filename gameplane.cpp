#include "gameplane.h"

#include <QTime>

#include "settings.h"

extern QString appPath;

/*ctor*/
GamePlane::GamePlane(QQuickItem *parent) : QQuickItem(parent), c_movesCounter(0),
    c_foregroundGridController(nullptr), c_foregroundGrid(nullptr), c_currentLevel(nullptr){
}

GamePlane::~GamePlane(){
    delete c_foregroundGridController;
}

/*private*/
void GamePlane::makeSoundEffect(){
    c_movesCounter++;
    emit soundEffect();
}

QQuickItem * GamePlane::foregroundGrid() const{
    return c_foregroundGrid;
}

void GamePlane::setForegroundGrid(QQuickItem *grid){
    delete c_foregroundGridController;
    c_foregroundGrid = grid;
    c_foregroundGrid->setParent(this);
    c_foregroundGrid->setParentItem(this);
    c_foregroundGridController = new GridController(c_foregroundGrid);
    connect(c_foregroundGridController, &GridController::solved, this, &GamePlane::openNewLevel);
    connect(c_foregroundGridController, &GridController::makeMoveSound, this, &GamePlane::makeSoundEffect);
}

/*public Q_INVOKABLE*/
void GamePlane::restartLevel(){
    loadLevel(c_currentLevel);
}

void GamePlane::loadLevel(Level *level){
    c_currentLevel = level;
    c_movesCounter = 0;

    if(c_foregroundGrid) {
        Level foregroundLevel(*level);
        QVariantList foregroundHints(foregroundLevel.hints());
        std::for_each(foregroundHints.begin(), foregroundHints.end(), [](QVariant &hint){
           hint = QVariant(hint.toInt());
        });
        foregroundLevel.setHints(foregroundHints);
        c_foregroundGridController->loadLevel(foregroundLevel, true);

        c_timer.start();
    }
}

/*public slots*/
void GamePlane::openNewLevel(){
    Settings settings;
    int newLevelId = c_currentLevel->levelId() + 1;
    if(newLevelId < settings.levelsCount()) settings.setLevelOpened(newLevelId, true);
    GameResult result;
    result.setLevelId(newLevelId);
    result.setMoves(c_movesCounter);
    result.setTime(QTime::fromMSecsSinceStartOfDay(c_timer.elapsed()).toString("mm:ss"));
    emit newLevelOpened(&result);
}
