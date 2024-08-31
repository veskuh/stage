import QtQuick
import QtQuick.Controls

ToolButton {
    id: button
    checkable: true
    icon.width: 32
    icon.height: (Qt.platform.os === "osx") ? 26 : 32

    display: icon.source != "" ? AbstractButton.TextUnderIcon : AbstractButton.TextOnly
}
