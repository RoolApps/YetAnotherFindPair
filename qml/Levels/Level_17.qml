import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 17
    rows: 6
    columns: 3
    difficulty: 30
    hints:
        [Game.Tree,
        Game.Cupcake,
        Game.Cloud,

        Game.Cactus,
        Game.Diamond,
        Game.Glasses,

        Game.Candle,
        Game.Apple,
        Game.Ball,

        Game.Peach,
        Game.Mushroom,
        Game.Pizza,

        Game.Icecream,
        Game.Feather,
        Game.Sun,

        Game.Strawberry,
        Game.Bug,
        Game.Turtle
    ]
}
