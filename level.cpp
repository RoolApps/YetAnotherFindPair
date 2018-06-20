#include "level.h"

#include <ctime>

/*ctor*/
Level::Level(QObject *parent) : QObject(parent), c_levelId(0), c_rows(0), c_columns(0), c_difficulty(0){
    srand(time(NULL));
}

Level::Level(Level const &level) : QObject(nullptr){
    *this = level;
}

Level & Level::operator=(Level const &level){
    if(this == &level) return *this;
    c_levelId = level.c_levelId;
    c_rows = level.c_rows;
    c_columns = level.c_columns;
    c_difficulty = level.c_difficulty;
    c_hints = level.c_hints;
    return *this;
}

/*public*/
int Level::levelId() const{
    return c_levelId;
}

void Level::setLevelId(int id){
    if(c_levelId != id){
        c_levelId = id;
        emit levelIdChanged();
    }
}

int Level::rows() const{
    return c_rows;
}

void Level::setRows(int rows){
    if(c_rows != rows){
        c_rows = rows;
        emit rowsChanged();
    }
}

int Level::columns() const{
    return c_columns;
}

void Level::setColumns(int columns){
    if(c_columns != columns){
        c_columns = columns;
        emit columnsChanged();
    }
}

float Level::difficulty() const{
    return c_difficulty;
}

void Level::setDifficulty(float difficulty){
    if(c_difficulty != difficulty){
        c_difficulty = difficulty;
        emit difficultyChanged();
    }
}

QList<QVariant> Level::hints() const{
    return c_hints;
}

void Level::setHints(QList<QVariant> &list){
    if(c_hints != list){
        c_hints = list;
        emit hintsChanged();
    }
}

void Level::shuffle(){
//    Index previousStep;
//    for(int steps = 0; steps < static_cast<int>(c_difficulty * 10);){
//        int row = empty / c_columns;
//        int col = empty % c_columns;
//        Index indexes[] = {Index(0, -1), Index(0, 1), Index(-1, 0), Index(1, 0)};
//        Index step = indexes[rand() % (sizeof(indexes) / sizeof(*indexes))];
//        if( (step == indexes[Game::Left] && previousStep == indexes[Game::Right]) ||
//            (step == indexes[Game::Right] && previousStep == indexes[Game::Left]) ||
//            (step == indexes[Game::Up] && previousStep == indexes[Game::Down]) ||
//            (step == indexes[Game::Down] && previousStep == indexes[Game::Up])) continue;
//        Index move(row + step.r, col + step.c);
//        if(move.isValid(c_rows, c_columns)){
//            previousStep = step;
//            int index = move.r * c_columns + move.c;
//            std::swap(c_hints[empty], c_hints[index]);
//            empty = index;
//            steps++;
//        }
//    }
}
