import QtQuick 2.0
import QtQuick.Dialogs 1.0

Image {
    id: image

    property bool selected: false
    property alias dialog: fileDialog

    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent

        onClicked: {
            mainWindow.target = image
            mainWindow.inspectorSource = "ImageInspector.qml"
        }
    }


    opacity: dragArea.drag.active? 0.5 : 1.0

    FileDialog {
        id: fileDialog
        title: "Choose image"

        selectMultiple: false
        onAccepted: {
            image.source = fileDialog.fileUrl
        }
        nameFilters: [ "Image filels (*.jpg *.png)"]
    }


    Component.onCompleted: {
        fileDialog.visible = true
    }

}
