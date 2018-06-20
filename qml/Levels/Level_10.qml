import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 10
    rows: 5
    columns: 3
    difficulty: 25
    hints:
        [Game.Apple,
        Game.Bulb,
        Game.Flower,

        Game.Glasses,
        Game.Diamond,
        Game.Cup,

        Game.Bug,
        Game.Candy,
        Game.Bird,

        Game.Bear,
        Game.Eye,
        Game.Pawprint,

        Game.Peach,
        Game.Plant,
        Game.Shell
    ]
}
