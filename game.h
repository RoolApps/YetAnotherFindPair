#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QQuickItem>
#include <QQmlEngine>

#include "utils.h"

#define GAME_ORGANIZATION "ROOL APPS"
#define GAME_NAME "Yet Another Find Pair"
#define GAME_LEVELS_COUNT 23

class Game : public QObject {
    Q_OBJECT

    Q_PROPERTY(QQmlEngine * engine READ engine WRITE setEngine)

public:
    enum MoveDirection {Left, Right, Up, Down};
    enum CellType {
                   Transparent,
                   Bug,
                   Flower,
                   Pepper,
                   Apple,
                   Ball,
                   Bird,
                   Bagel,
                   Cactus,
                   Cat,
                   Cloud,
                   Cup,
                   Cupcake,
                   Diamond,
                   Eye,
                   Feather,
                   Icecream,
                   Leaf,
                   Mushroom,
                   Peach,
                   Pizza,
                   Plant,
                   Soda,
                   Sun,
                   Tree,
                   Turtle,
                   Umbrella,
                   Candle,
                   Candy,
                   Glasses,
                   Bulb,
                   Medusa,
                   Pawprint,
                   Shell,
                   Strawberry,
                   Bear
                  };
    Q_ENUM(MoveDirection)
    Q_ENUM(CellType)

private:
    static QQmlEngine *c_engine;

public:
    Game(QObject * = 0);

public:
    static QQmlEngine * engine();
    static void setEngine(QQmlEngine *);
    static QQuickItem * createQmlObject(QString const);
    static QString cellTypeAsString(CellType);
    static QString fullImagePath(CellType);
    static QString fullFrontImagePath(CellType);

signals:

public slots:
};

#endif // GAMELOGIC_H
