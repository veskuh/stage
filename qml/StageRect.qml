import QtQuick 2.0

StageBase {
    inspectorSource: "RectInspector.qml"
    property alias color: rect.color
    width: 100
    height: 62

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "blue"
    }
}
