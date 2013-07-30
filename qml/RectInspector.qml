import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: inspector
    anchors.fill: parent

    property Item target: mainWindow.target

    Column {
        InspectorCommon {
            title: "Rectangle"
        }


        Label {
            text: "R"
        }
        Slider {
            value: inspector.target? inspector.target.color.r : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                inspector.target.color.r = value
            }
        }
        Label {
            text: "G"
        }
        Slider {
            value: inspector.target? inspector.target.color.g : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                inspector.target.color.g = value
            }
        }
        Label {
            text: "B"
        }
        Slider {
            value: inspector.target? inspector.target.color.b : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                if (inspector.target) inspector.target.color.b = value
            }
        }
    }
}
