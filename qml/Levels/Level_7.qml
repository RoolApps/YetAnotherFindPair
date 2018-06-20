import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 7
    rows: 2
    columns: 5
    difficulty: 25
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
        Game.Icecream
    ]
}
