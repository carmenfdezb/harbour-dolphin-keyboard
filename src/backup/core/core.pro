TEMPLATE = lib
TARGET = harbour-dolphin
QT += qml quick sql
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = harbour.dolphin.core

# Input
SOURCES += \
    settings.cpp \
    database.cpp \
    core.cpp

HEADERS += \
    settings.h \
    database.h \
    core.h

OTHER_FILES = qmldir

# Install
installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)

qmldir.files = qmldir
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir
