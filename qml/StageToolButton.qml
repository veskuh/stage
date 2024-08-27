import QtQuick
import QtQuick.Controls

ToolButton {
    id: button
    checkable: true
    icon.width: 24
    icon.height: 24
    property alias toolSymbol : symbolLabel.text

    Label {
        id: symbolLabel
        font.family: "SF Pro"
        text: ""
        visible: Qt.platform.os === "osx"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: theme.mediumPadding
        font.pointSize: 18
    }

    display: AbstractButton.TextUnderIcon
}
