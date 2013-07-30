import QtQuick 2.0

Rectangle {
    id: rect

    width: 100
    height: 62

    property bool selected: false
    color: "blue"

    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent

        onClicked: {
            mainWindow.target = rect
            mainWindow.inspectorSource = "RectInspector.qml"
        }
    }


    opacity: dragArea.drag.active? 0.5 : 1.0

}
