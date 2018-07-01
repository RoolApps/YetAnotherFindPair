#include "cellcontroller.h"

extern QString appPath;

/*ctor*/
CellController::CellController(Item object) : IQmlComponentController(object) {
    connect(c_qmlObject, SIGNAL(animationStopped()), this, SLOT(onAnimationStopped()));
    connect(c_qmlObject, SIGNAL(clicked()), this, SLOT(onClicked()));
    connect(c_qmlObject, SIGNAL(rotationStopped()), this, SLOT(onRotationStopped()));
}

/*public*/
bool CellController::canRotate() {
    return c_canRotate;
}

void CellController::setCanRotate(bool canRotate) {
    c_canRotate = canRotate;
}

bool CellController::flipped() {
    return read(c_qmlObject, "flipped").toBool();
}

Game::CellType CellController::type() const {
    return c_type;
}

void CellController::setType(Game::CellType type) {
    write(c_qmlObject, "source", Game::fullImagePath(type));
    write(c_qmlObject, "frontSource", Game::fullFrontImagePath(type));
    c_type = type;
}

QPoint CellController::getPosition() {
    return QPoint(read(c_qmlObject, "x").toInt(), read(c_qmlObject, "y").toInt());
}

void CellController::setPosition(QPoint point) {
    write(c_qmlObject, "x", point.x());
    write(c_qmlObject, "y", point.y());
}

/*public virtual*/
void CellController::info() const {
    return IQmlComponentController::info();
}

/*private slots*/
void CellController::onAnimationStopped() {
    cellMovementStopped(this);
}

void CellController::onRotationStopped() {
    if(flipped()) {
        cellRotationStopped(this);
    }
}

void CellController::rotate() {
    write(c_qmlObject, "flipped", !flipped());
}

void CellController::onClicked() {
    cellClicked(this);
}
