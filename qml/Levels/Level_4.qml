import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 4
    rows: 3
    columns: 4
    difficulty: 15
    hints:
        [Game.Feather,
        Game.Sun,
        Game.Umbrella,
        Game.Pizza,

        Game.Bug,
        Game.Leaf,
        Game.Cactus,
        Game.Apple,


        Game.Cat,
        Game.Cloud,
        Game.Tree,
        Game.Turtle
    ]
}
