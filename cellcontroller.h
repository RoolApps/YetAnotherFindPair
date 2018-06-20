#ifndef CELLCONTROLLER_H
#define CELLCONTROLLER_H

#include "game.h"
#include "iqmlcomponentcontroller.h"
#include <QPoint>

class CellController : public QObject, public IQmlComponentController{
    Q_OBJECT

private:
    bool c_canRotate = true;
    Game::CellType c_type;
    bool flipped();

public:
    explicit CellController(Item = nullptr);

public:
    bool canRotate();
    Game::CellType type() const;
    void setType(Game::CellType);
    void moveLeft(int);
    void moveRight(int);
    void moveUp(int);
    void moveDown(int);
    QPoint getPosition();
    void setPosition(QPoint);
    void rotate();
    void setCanRotate(bool);

public:
    virtual void info() const;

private slots:
    void onAnimationStopped();
    void onClicked();
    void onRotationStopped();

signals:
    void cellClicked(CellController *);
    void cellRotationStopped(CellController *);
    void cellMovementStopped(CellController *);
};

#endif // CELLCONTROLLER_H
