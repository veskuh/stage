import QtQuick 2.0

Item {
    id: base

    property alias inspectorSource: dragArea.source
    property bool selected: false
    opacity: dragArea.drag.active? 0.5 : 1.0

    StageMouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        target: base
    }
}
