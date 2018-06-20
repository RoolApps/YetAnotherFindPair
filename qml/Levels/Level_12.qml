import QtQuick 2.9

import CppItems 0.1

Level {
    id: root
    levelId: 12
    rows: 5
    columns: 4
    difficulty: 25
    hints:
        [Game.Medusa,
        Game.Soda,
        Game.Bug,
        Game.Plant,

        Game.Bug,
        Game.Cactus,
        Game.Icecream,
        Game.Bagel,

        Game.Cloud,
        Game.Pawprint,
        Game.Candle,
        Game.Peach,

        Game.Apple,
        Game.Bird,
        Game.Bear,
        Game.Glasses,

        Game.Eye,
        Game.Tree,
        Game.Strawberry,
        Game.Umbrella
    ]
}
