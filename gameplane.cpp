#include "gameplane.h"

#include <QTime>

#include "settings.h"

extern QString appPath;

/*ctor*/
GamePlane::GamePlane(QQuickItem *parent) : QQuickItem(parent), c_movesCounter(0),
    c_foregroundGridController(nullptr), c_foregroundGrid(nullptr), c_backgroundGrid(nullptr), c_currentLevel(nullptr){

    c_tickTimer.setInterval(1000);
    connect(&c_tickTimer, SIGNAL(timeout()), this, SLOT(timerTick()));
    c_tickTimer.start();
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

QQuickItem * GamePlane::backgroundGrid() const{
    return c_backgroundGrid;
}

void GamePlane::setForegroundGrid(QQuickItem *grid){
    delete c_foregroundGridController;
    c_foregroundGrid = grid;
    c_foregroundGrid->setParent(this);
    c_foregroundGrid->setParentItem(this);
    c_foregroundGridController = new GridController(c_foregroundGrid);
    connect(c_foregroundGridController, &GridController::solved, this, &GamePlane::openNewLevel);
    connect(c_foregroundGridController, &GridController::makeMoveSound, this, &GamePlane::makeSoundEffect);
    if(c_backgroundGrid != nullptr) {
        connect(c_foregroundGrid, SIGNAL(heightChanged()), this, SLOT(foregroundGridHeightChanged()));
    }
}

void GamePlane::foregroundGridHeightChanged() {
    if(c_foregroundGrid!=nullptr) {
        c_backgroundGrid->setHeight(c_foregroundGrid->height() + c_magicNumber);
        c_backgroundGrid->setWidth(c_foregroundGrid->width() + c_magicNumber);
    }
}

void GamePlane::setBackgroundGrid(QQuickItem * grid){
    c_backgroundGrid = grid;
    c_backgroundGrid->setParent(this);
    c_backgroundGrid->setParentItem(this);
    if(c_foregroundGrid != nullptr) {
        foregroundGridHeightChanged();
        connect(c_foregroundGrid, SIGNAL(heightChanged()), this, SLOT(foregroundGridHeightChanged()));
    }
}

/*public Q_INVOKABLE*/
void GamePlane::restartLevel(){
    loadLevel(c_currentLevel);
}

QVariantList GamePlane::generateHints(int rows, int columns) {
    int types = rows * columns / 2;

    const QMetaObject *metaObject = qt_getEnumMetaObject(Game::CellType());
    const char *name = qt_getEnumName(Game::CellType());
    QMetaEnum cellType = metaObject->enumerator(metaObject->indexOfEnumerator(name));
    int length = cellType.keyCount();
    QVector<int> vector = QVector<int>();
    for(int i=0;i<length;i++) {
        if((int)Game::CellType::Transparent != i) {
            vector.append(i);
        }
    }
    std::random_shuffle(vector.begin(), vector.end());
    QVariantList hints = QVariantList();
    for(int i=0;i<types;i++) {
       hints.append(QVariant(vector.at(i)));
       hints.append(QVariant(vector.at(i)));
    }
    if (types * 2 != rows * columns) {
        hints.append(QVariant((int)Game::CellType::Transparent));
    }
    std::random_shuffle(hints.begin(), hints.end());
    return hints;
}

void GamePlane::loadLevel(Level *level){
    if(c_currentLevel != nullptr) {

    }
    c_currentLevel = level;
    c_movesCounter = 0;

    if(c_foregroundGrid) {
        Level foregroundLevel(*level);

        QVariantList foregroundHints = generateHints(level->rows(), level->columns());
        foregroundLevel.setHints(foregroundHints);
        c_foregroundGridController->loadLevel(foregroundLevel, true);
        foregroundGridHeightChanged();

        c_timer.start();
        secondsElapsed = -1;
        timerTick();
    }
}

void GamePlane::timerTick() {
    secondsElapsed++;
    QTime time = QTime(0, secondsElapsed / 60, secondsElapsed % 60);
    emit secondTick(time.toString("mm:ss"));
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
