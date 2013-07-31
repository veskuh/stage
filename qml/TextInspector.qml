import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: inspector
    anchors.fill: parent
    color: palette.window
    property Item target: mainWindow.target

    Column {

        InspectorCommon {
            title: "Text"
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
    }
}
