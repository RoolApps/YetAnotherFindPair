import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 3
    rows: 3
    columns: 3
    difficulty: 15
    hints:
        [Game.Bird,
        Game.Umbrella,
        Game.Cat,

        Game.Umbrella,
        Game.Transparent,
        Game.Turtle,

        Game.Bird,
        Game.Turtle,
        Game.Cat
    ]
}
