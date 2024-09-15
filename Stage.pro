QT+=widgets qml quick svg

MOC_DIR = moc
RCC_DIR = qrc
OBJECTS_DIR = obj

SOURCES += \
    src/declarativeclipboard.cpp \
    src/declarativedocument.cpp \
    src/documentfile.cpp \
    src/stage.cpp \
    src/svgexport.cpp

HEADERS += \
    src/declarativeclipboard.h \
    src/declarativedocument.h \
    src/documentfile.h \
    src/macsymbolimageprovider.h \
    src/svgexport.h

RESOURCES += \
    resources.qrc

# TBD
macx* {
    ICON = deploy/mac/stage.icns
    RC_FILE = deploy/mac/stage.icns
    QMAKE_INFO_PLIST = deploy/mac/Info.plist
    CONFIG += sdk_no_version_check # To avoid warnings with Big Sur
    SOURCES += src/macsymbolimageprovider.mm
    LIBS += -framework Cocoa
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
