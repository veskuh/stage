import QtQuick 2.0

MouseArea {
    property Item target
    property string source: ""

    enabled: mainWindow.select


    onClicked: {
        mainWindow.target = target
        mainWindow.inspectorSource = source
    }
}
