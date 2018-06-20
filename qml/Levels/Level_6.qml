import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 6
    rows: 4
    columns: 4
    difficulty: 20
    hints:
        [Game.Bug,
        Game.Bird,
        Game.Peach,
        Game.Pepper,

        Game.Mushroom,
        Game.Leaf,
        Game.Pizza,
        Game.Bug,

        Game.Turtle,
        Game.Icecream,
        Game.Cup,
        Game.Glasses,

        Game.Cactus,
        Game.Diamond,
        Game.Sun,
        Game.Apple
    ]
}
