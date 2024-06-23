QT+=widgets qml quick




SOURCES += \
    declarativedocument.cpp \
    documentfile.cpp \
    stage.cpp

HEADERS += \
    declarativedocument.h \
    documentfile.h

RESOURCES += \
    resources.qrc


macx* {
    ICON = deploy/macOS/icon.icns
    RC_FILE = deploy/macOS/icon.icns
    QMAKE_INFO_PLIST = deploy/macOS/info.plist
    CONFIG += sdk_no_version_check # To avoid warnings with Big Sur
}

linux: {
    TARGET = stage

    target.path = /usr/bin
    icon.path = /usr/share/pixmaps
    desktop.path = /usr/share/applications
    icon.files += deploy/linux/*.png
    desktop.files += deploy/linux/*.desktop

    INSTALLS += target desktop icon
}
