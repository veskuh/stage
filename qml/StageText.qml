import QtQuick 2.0
import QtQuick.Controls 1.0

StageBase {
    inspectorSource: "TextInspector.qml"
    property alias text: label.text
    property alias color: label.color
    width: 100
    height: 62

    Label {
        id:label
        anchors.fill: parent
        text: "Hello World"
        color: "black"
    }
}
