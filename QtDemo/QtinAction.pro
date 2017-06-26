TEMPLATE = app

QT += qml charts quick xmlpatterns sql svg multimedia quickcontrols2

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

android {
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

DISTFILES += \
    android/AndroidManifest.xml \
    qml/QtDemo/demos/polarchart/main.qml \
    qml/QtDemo/demos/polarchart/View1.qml \
    qml/QtDemo/demos/polarchart/View2.qml \
    qml/QtDemo/demos/polarchart/View3.qml
