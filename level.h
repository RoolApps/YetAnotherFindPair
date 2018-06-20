#ifndef LEVEL_H
#define LEVEL_H

#include <QQuickItem>

#include "game.h"

/*
 * 0 - Empty
 * 1 - Red triangle
 * 2 - Red rectangle
 * 3 - Red circle
*/

class Level : public QObject{
    Q_OBJECT

    Q_PROPERTY(int levelId READ levelId WRITE setLevelId NOTIFY levelIdChanged)
    Q_PROPERTY(int rows READ rows WRITE setRows NOTIFY rowsChanged)
    Q_PROPERTY(int columns READ columns WRITE setColumns NOTIFY columnsChanged)
    Q_PROPERTY(float difficulty READ difficulty WRITE setDifficulty NOTIFY difficultyChanged)
    Q_PROPERTY(QVariantList hints READ hints WRITE setHints NOTIFY hintsChanged)

private:
    int c_levelId;
    int c_rows;
    int c_columns;
    float c_difficulty;
    QVariantList c_hints;

public:
    Level(QObject * = nullptr);
    Level(Level const &);
    Level & operator=(Level const &);

public:
    int levelId() const;
    void setLevelId(int);
    int rows() const;
    void setRows(int);
    int columns() const;
    void setColumns(int);
    float difficulty() const;
    void setDifficulty(float);
    QVariantList hints() const;
    void setHints(QVariantList &);

    void shuffle();

signals:
    void levelIdChanged();
    void rowsChanged();
    void columnsChanged();
    void difficultyChanged();
    void hintsChanged();

public slots:

};

#endif // LEVEL_H
