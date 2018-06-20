import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 5
    rows: 4
    columns: 3
    difficulty: 15
    hints:
        [Game.Cupcake,
        Game.Bagel,
        Game.Cat,

        Game.Pepper,
        Game.Icecream,
        Game.Soda,

        Game.Bird,
        Game.Cactus,
        Game.Diamond,

        Game.Peach,
        Game.Apple,
        Game.Bug
    ]
}
