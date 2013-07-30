import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: inspector
    anchors.fill: parent

    property Item target: mainWindow.target

    Column {
        Label {
            text: "Text"
        }

        Label {
            text: "X"
        }

        TextField {
            text: inspector.target? inspector.target.x : ""
            validator: IntValidator { bottom: -1024; top: 1024 }
            enabled: inspector.target
            onAccepted: {
                inspector.target.x = parseInt(text)
            }
        }
        Label {
            text: "Y"
        }

        TextField {
            text: inspector.target? inspector.target.y : ""
            validator: IntValidator { bottom: -1024; top: 1024 }
            enabled: inspector.target
            onAccepted: {
                inspector.target.y = parseInt(text)
            }

        }

        Label {
            text: "Width"
        }

        TextField {
            text: inspector.target? inspector.target.width : ""
            validator: IntValidator { bottom: -1024; top: 1024 }
            enabled: inspector.target
            onAccepted: {
                inspector.target.width = parseInt(text)
            }
        }
        Label {
            text: "Height"
        }

        TextField {
            text: inspector.target? inspector.target.height : ""
            validator: IntValidator { bottom: -1024; top: 1024 }
            enabled: inspector.target
            onAccepted: {
                inspector.target.height = parseInt(text)
            }

        }

        Label {
            text: "Text"
        }

        TextField {
            text: inspector.target? inspector.target.text : ""
            enabled: inspector.target
            onTextChanged: {
                if (inspector.target) inspector.target.text = text
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
