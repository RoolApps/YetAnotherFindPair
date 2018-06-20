import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 8
    rows: 5
    columns: 2
    difficulty: 25
    hints:
        [Game.Bulb,
        Game.Mushroom,

        Game.Medusa,
        Game.Shell,

        Game.Strawberry,
        Game.Bug,

        Game.Soda,
        Game.Diamond,

        Game.Pepper,
        Game.Bug
    ]
}
