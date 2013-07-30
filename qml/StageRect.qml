import QtQuick 2.0

Rectangle {
    id: rect

    width: 100
    height: 62

    property bool selected: false
    color: "blue"
    opacity: dragArea.drag.active? 0.5 : 1.0

    StageMouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        target: rect
        source: "RectInspector.qml"
    }
}
