import QtQuick 2.0

Item {
    id: handle
    visible: parent.selected

    property Item dragTarget
    property real initialWidth
    property real initialHeight


    x: parent.width - width/2
    y: parent.height - height/2

    width: 11
    height: 11

    Rectangle {
        id: indicator

        width: 5
        height: 5
        color: "red"
        anchors.centerIn: parent
    }

    MouseArea {
        id: dragArea
        drag.target: handle
        anchors.fill: parent
        property bool dragging: drag.active

        onMouseXChanged: {
            if(dragging) {
                var x = handle.x
                handle.parent.width = x + handle.width/2
            }
        }

        onMouseYChanged: {
            if(dragging) {
                var y = handle.y
                handle.parent.height = y + handle.height/2
            }
        }
    }
    z: parent.z + 1
}
