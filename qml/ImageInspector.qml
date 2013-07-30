import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: inspector
    anchors.fill: parent

    property Item target: mainWindow.target

    Column {
        InspectorCommon {
            title: "Image"
        }

        Label {
            text: inspector.target? "Source: " + inspector.target.source : "No source"
        }
        Button {
            text: "Change source.."
            onClicked: {
                inspector.target.dialog.visible = true
            }
        }
        Button {
            text: "Delete"
            onClicked: {
                var element  = inspector.target
                inspector.target = null
                element.destroy()
            }
        }
    }
}
