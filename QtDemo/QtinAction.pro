TEMPLATE = app

QT += qml quick xmlpatterns sql svg multimedia quickcontrols2

SOURCES += main.cpp \
    filereader.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
QTPLUGIN += qsqlite

OTHER_FILES += \
    android/AndroidManifest.xml

HEADERS += \
    filereader.h

ANDROID_PACKAGE_SRC_DIR = $$PWD/android

DISTFILES += \
    android/AndroidManifest.xml
