import QtQuick
import QtQml
import QtQuick.Controls

QtObject {
    id: theme

    // Common Paddings
    property int smallPadding: (Qt.platform.os === "osx") ? 4 : 6
    property int mediumPadding: smallPadding * 2
    property int largePadding: mediumPadding * 2

    // Font Sizes
    property int smallFontSize: (Qt.platform.os === "osx") ? 12 : 14
    property int mediumFontSize: (Qt.platform.os === "osx") ? 14 : 16
    property int largeFontSize: (Qt.platform.os === "osx") ? 18 : 20

    // Tool icons
    property string selectIcon: "file:///usr/share/icons/breeze/actions/16/select-symbolic.svg"
    property string rectIcon: "file:///usr/share/icons/breeze/actions/16/draw-rectangle-symbolic.svg"
    property string circleIcon: "file:///usr/share/icons/breeze/actions/16/draw-circle-symbolic.svg"
    property string textIcon: "file:///usr/share/icons/breeze/actions/16/draw-text-symbolic.svg"
    property string imageIcon: "file:///usr/share/icons/breeze/actions/16/insert-image-symbolic.svg"
}

