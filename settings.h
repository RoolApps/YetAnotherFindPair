#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

#include "game.h"

class Settings : public QSettings{
    Q_OBJECT

public:
    explicit Settings(QObject * = nullptr);

public:
    Q_INVOKABLE void print() const;
    Q_INVOKABLE int levelId(int) const;
    Q_INVOKABLE bool levelOpened(int) const;
    Q_INVOKABLE void setLevelOpened(int, bool);
    Q_INVOKABLE int levelsCount() const;
    Q_INVOKABLE bool backgroundMusic() const;
    Q_INVOKABLE void setBackgroundMusic(bool);
    Q_INVOKABLE bool slideEffectSound() const;
    Q_INVOKABLE void setSlideEffectSound(bool);
    Q_INVOKABLE bool timer() const;
    Q_INVOKABLE void setTimer(bool);

signals:
    void levelStateChanged(int, bool);
    void backgroundMusicStateChanged(bool);
    void slideEffectSoundStateChanged(bool);
    void timerStateChanged(bool);
};

#endif // SETTINGS_H
