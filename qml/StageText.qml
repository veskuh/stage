import QtQuick 2.0
import QtQuick.Controls 1.0

Label {
    id: label

    property string inspectorSource: "TextInspector.qml"
    property bool selected: false

    width: 100
    height: 62
    text: "Hello World"
    color: "black"
    opacity: dragArea.drag.active? 0.5 : 1.0

    StageMouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        target: label
        source: "TextInspector.qml"
    }
}
