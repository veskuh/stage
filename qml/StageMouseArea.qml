import QtQuick 2.0

MouseArea {
    property Item target
    property string source: ""

    enabled: mainWindow.select


    property bool dragging: drag.active

    onClicked: {
        mainWindow.target = target
        mainWindow.inspectorSource = source
    }

    onDraggingChanged: {
        if(dragging) {
            mainWindow.draggedObject = parent
        } else {
            mainWindow.draggedObject = null
        }
    }
}
