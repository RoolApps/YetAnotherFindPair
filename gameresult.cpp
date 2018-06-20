#include "gameresult.h"

/*ctor*/
GameResult::GameResult(QObject *parent) : QObject(parent), c_levelId(0), c_moves(0){

}

/*public*/
int GameResult::levelId() const{
    return c_levelId;
}

void GameResult::setLevelId(int id){
    if(c_levelId != id){
        c_levelId = id;
        emit levelIdChanged();
    }
}

int GameResult::moves() const{
    return c_moves;
}

void GameResult::setMoves(int moves){
    if(c_moves != moves){
        c_moves = moves;
        emit movesChanged();
    }
}

QString GameResult::time() const{
    return c_time;
}

void GameResult::setTime(QString time){
    if(c_time != time){
        c_time = time;
        emit timeChanged();
    }
}
