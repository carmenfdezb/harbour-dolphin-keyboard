TEMPLATE = lib
TARGET = harbour-dolphin-keyboard
QT += qml quick sql
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = harbour.dolphin.keyboard

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
