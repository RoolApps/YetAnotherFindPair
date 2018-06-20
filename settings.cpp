#include "settings.h"

/*ctor*/
Settings::Settings(QObject *parent) : QSettings("app.ini", QSettings::IniFormat, parent){
    if(!contains("settingsInitialized")){
        setValue("settingsInitialized", true);

        // Levels
        beginWriteArray("levels");
        for(int id = 0; id < GAME_LEVELS_COUNT; id++){
            setArrayIndex(id);
            setValue("id", id);
            setValue("open", false);
        }
        endArray();
        setValue("levels/1/open", true);

        // Sound
        beginGroup("sound");
        setValue("backgroundMusic", true);
        setValue("slideEffectSound", true);
        endGroup();

        // Timer
        setValue("timer", false);
    }
}

/*public INVOKABLE*/
void Settings::print() const{
    dbg << "SETTINGS:";
    dbg << value("settingsInitialized").toBool();
    dbg << value("levels/size");
}

int Settings::levelId(int id) const{
    QString val = QString("levels/%1/id").arg(++id);
    return value(val).toInt();
}

bool Settings::levelOpened(int id) const{
    QString val = QString("levels/%1/open").arg(++id);
    return value(val).toBool();
}

void Settings::setLevelOpened(int id, bool state){
    QString target = QString("levels/%1/open").arg(++id);
    setValue(target, state);
    emit levelStateChanged(id, state);
}

int Settings::levelsCount() const{
    return value("levels/size").toInt();
}

bool Settings::backgroundMusic() const{
    return value("sound/backgroundMusic").toBool();
}

void Settings::setBackgroundMusic(bool state){
    setValue("sound/backgroundMusic", state);
    emit backgroundMusicStateChanged(state);
}

bool Settings::slideEffectSound() const{
    return value("sound/slideEffectSound").toBool();
}

void Settings::setSlideEffectSound(bool state){
    setValue("sound/slideEffectSound", state);
    emit slideEffectSoundStateChanged(state);
}

bool Settings::timer() const{
    return value("timer").toBool();
}

void Settings::setTimer(bool state){
    setValue("timer", state);
    emit timerStateChanged(state);
}
