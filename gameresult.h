#ifndef GAMERESULT_H
#define GAMERESULT_H

#include "game.h"

class GameResult : public QObject {
    Q_OBJECT

    Q_PROPERTY(int levelId READ levelId WRITE setLevelId NOTIFY levelIdChanged)
    Q_PROPERTY(int moves READ moves WRITE setMoves NOTIFY movesChanged)
    Q_PROPERTY(QString time READ time WRITE setTime NOTIFY timeChanged)

private:
    int c_levelId;
    int c_moves;
    QString c_time;

public:
    explicit GameResult(QObject *parent = nullptr);

public:
    int levelId() const;
    void setLevelId(int);
    int moves() const;
    void setMoves(int);
    QString time() const;
    void setTime(QString);

signals:
    void levelIdChanged();
    void movesChanged();
    void timeChanged();

public slots:
};

#endif // GAMERESULT_H
