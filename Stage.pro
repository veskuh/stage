QT+=widgets qml quick

MOC_DIR = moc
RCC_DIR = qrc
OBJECTS_DIR = obj

SOURCES += \
    src/declarativedocument.cpp \
    src/documentfile.cpp \
    src/stage.cpp

HEADERS += \
    src/declarativedocument.h \
    src/documentfile.h

RESOURCES += \
    resources.qrc

# TBD
macx* {
    ICON = deploy/mac/stage.icns
    RC_FILE = deploy/mac/stage.icns
    QMAKE_INFO_PLIST = deploy/mac/Info.plist
    CONFIG += sdk_no_version_check # To avoid warnings with Big Sur
}

linux: {
    TARGET = stage

    # Define default prefix
    prefix = "/usr"

    contains(FLATPAK_BUILD, 1) {
       prefix = "/app"
        message("Flatpak build detected, prefix set to: $$prefix")
    } else {
        message("Regular build detected, prefix set to: $$prefix")
    }

    # Define installation paths
    target.path = $$prefix/bin
    desktop.path = $$prefix/share/applications
    icon.path = $$prefix/share/pixmaps

    icon.files += deploy/linux/*.png
    desktop.files += deploy/linux/*.desktop

    INSTALLS += target desktop icon

    # Create desktop file from template
    #desktop.commands = $(INSTALL_ROOT)$(desktop.path)/stage.desktop
    #desktop.commands = sed 's|Exec=/usr|Exec=$${prefix}/|' deploy/linux/stage.desktop > stage.desktop



}
