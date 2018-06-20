import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 1
    rows: 2
    columns: 3
    difficulty: 10
    hints:
        [Game.Peach,
        Game.Sun,
        Game.Bug,

        Game.Bug,
        Game.Sun,
        Game.Peach
    ]
}

