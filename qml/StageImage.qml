import QtQuick 2.0
import QtQuick.Dialogs 1.0

Image {
    id: image

    property bool selected: false
    property alias dialog: fileDialog

    opacity: dragArea.drag.active? 0.5 : 1.0

    StageMouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        target: image
        source: "ImageInspector.qml"
    }

    FileDialog {
        id: fileDialog
        title: "Choose image"
        selectMultiple: false
        nameFilters: [ "Image filels (*.jpg *.png)"]

        onAccepted: {
            image.source = fileDialog.fileUrl
        }
    }

    Component.onCompleted: {
        fileDialog.visible = true
    }
}
