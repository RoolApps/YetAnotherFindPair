QT += core svg quick multimedia
CONFIG += c++11

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/platform/android

#QMAKE_CXXFLAGS = -Wextra

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
    gameplane.h \
    level.h \
    game.h \
    gridcontroller.h \
    cellcontroller.h \
    iqmlcomponentcontroller.h \
    utils.h \
    settings.h \
    gameresult.h

SOURCES += main.cpp \
        gameplane.cpp \
        level.cpp \
        gridcontroller.cpp \
        cellcontroller.cpp \
        iqmlcomponentcontroller.cpp \
        game.cpp \
        settings.cpp \
        gameresult.cpp

RESOURCES += qml.qrc

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS \
           QTADMOB_QML

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

include (QtAdMob/QtAdMob.pri)

DISTFILES += \
    qml/Custom/qmldir

android:
{
    DISTFILES += \
        $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradle/wrapper/gradle-wrapper.jar \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradlew \
        $$ANDROID_PACKAGE_SOURCE_DIR/res/values/libs.xml \
        $$ANDROID_PACKAGE_SOURCE_DIR/build.gradle \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradle/wrapper/gradle-wrapper.properties \
        $$ANDROID_PACKAGE_SOURCE_DIR/gradlew.bat \
        $$ANDROID_PACKAGE_SOURCE_DIR/src/org/dreamdev/QtAdMob/QtAdMobActivity.java
}
