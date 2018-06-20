import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 2
    rows: 3
    columns: 2
    difficulty: 10
    hints:
        [Game.Bug,
        Game.Cup,

        Game.Cup,
        Game.Ball,

        Game.Bug,
        Game.Ball
    ]
}
