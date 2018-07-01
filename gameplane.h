#ifndef GAMEPLANE_H
#define GAMEPLANE_H

#include <QQuickItem>
#include <QQmlProperty>
#include <QSoundEffect>
#include <QElapsedTimer>
#include <QTimer>

#include "game.h"
#include "level.h"
#include "gridcontroller.h"
#include "gameresult.h"

class GamePlane : public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(QQuickItem * foregroundGrid READ foregroundGrid WRITE setForegroundGrid)
    Q_PROPERTY(QQuickItem * backgroundGrid READ backgroundGrid WRITE setBackgroundGrid)

private:
    int c_magicNumber = 50;
    int c_movesCounter;
    int secondsElapsed = 0;
    QElapsedTimer c_timer;
    QTimer c_tickTimer;
    GridController *c_foregroundGridController;
    QQuickItem *c_foregroundGrid;
    QQuickItem *c_backgroundGrid;
    Level *c_currentLevel;

public:
    explicit GamePlane(QQuickItem * = 0);
    ~GamePlane();

private:
    void makeSoundEffect();
    QVariantList generateHints(int, int);

private slots:
    void foregroundGridHeightChanged();
    void timerTick();

public:
    Q_INVOKABLE void restartLevel();
    Q_INVOKABLE void loadLevel(Level *);

public:
    QQuickItem * backgroundGrid() const;
    QQuickItem * foregroundGrid() const;
    void setForegroundGrid(QQuickItem *);
    void setBackgroundGrid(QQuickItem *);

signals:
    void newLevelOpened(GameResult *result);
    void soundEffect();
    void secondTick(QString);

public slots:
    void openNewLevel();
};

#endif // GAMEPLANE_H
