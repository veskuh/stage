import QtQuick
import QtQuick.Controls

ToolButton {
    id: button
    checkable: true
    icon.width: 24
    icon.height: 24
    display: (Qt.platform.os === "osx") ? AbstractButton.TextOnly : AbstractButton.TextUnderIcon
}
