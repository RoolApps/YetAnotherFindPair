#ifndef IQMLCOMPONENTCONTROLLER_H
#define IQMLCOMPONENTCONTROLLER_H

#include <QQuickItem>
#include <QQmlProperty>

#include "game.h"

typedef QQuickItem * Item;

class IQmlComponentController{
protected:
    Item c_qmlObject;

public:
    explicit IQmlComponentController(Item = nullptr);

public:
    Item qmlObject() const;
    void setQmlObject(Item);
    QVariant read(Item, QString) const;
    void write(Item, QString, QVariant);

public:
    virtual void info() const;
};

#endif // IQMLCOMPONENTCONTROLLER_H
