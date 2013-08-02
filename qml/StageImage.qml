import QtQuick 2.0
import QtQuick.Dialogs 1.0


StageBase {
    property alias dialog: fileDialog

    width: image.width
    height: image.height
    inspectorSource: "ImageInspector.qml"

    FileDialog {
        id: fileDialog
        title: "Choose image"
        selectMultiple: false
        nameFilters: [ "Image filels (*.jpg *.png)"]

        onAccepted: {
            image.source = fileDialog.fileUrl
        }
    }

    Image {
        id: image
    }
    Component.onCompleted: {
        fileDialog.visible = true
    }
}
