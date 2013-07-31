import QtQuick 2.0

Rectangle {
    id: anchorLine

    property bool vertical: true
    property int location: 0
    property bool enabled: true

    x: vertical ? location : 0
    y: vertical ? 0 : location
    width: vertical ? 1.0 :  mainWindow.view.width
    height: vertical ? mainWindow.view.height : 1.0

    color: "blue"
    z: 1000

    property bool freeOrActive: vertical? !mainWindow.verticalAnchor || mainWindow.verticalAnchor == anchorLine : !mainWindow.horizontalAnchor || mainWindow.horizontalAnchor == anchorLine
    visible: enabled && mainWindow.draggedObject && match() && freeOrActive

    function match() {
        var retval = false
        var dragged = mainWindow.draggedObject

        if (vertical) {
            if (Math.abs(dragged.x - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.x + dragged.width - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.x + dragged.width / 2 - location) < 10 ){
                return true
            }

        } else {
            if (Math.abs(dragged.y - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.y + dragged.height - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.y + dragged.height / 2 - location) < 10 ){
                return true
            }
        }


        return retval
    }

    onVisibleChanged: {
        if (vertical) {
            mainWindow.verticalAnchor = visible ? anchorLine : null
        } else {
            mainWindow.horizontalAnchor = visible? anchorLine : null
        }
    }

}
