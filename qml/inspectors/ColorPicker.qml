// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Column {
    id: root
    property color targetColor
    property bool enabled: false
    property real targetOpacity

    Label {
        text: "Red"
    }
    Slider {
        width: root.width - 2 * mainWindow.theme.mediumPadding
        value: targetColor? targetColor.r : 0
        enabled: root.enabled
        from: 0
        to: 1.0
        onValueChanged: {
            root.targetColor.r = value
        }
    }
    Label {
        text: "Green"
    }
    Slider {
        width: root.width - 2 * mainWindow.theme.mediumPadding
        value: targetColor? targetColor.g : 0
        enabled: root.enabled
        from: 0
        to: 1.0
        onValueChanged: {
            root.targetColor.g = value
        }
    }
    Label {
        text: "Blue"
    }
    Slider {
        width: root.width - 2 * mainWindow.theme.mediumPadding
        value: targetColor? targetColor.b : 0
        enabled: root.enabled
        from: 0
        to: 1.0
        onValueChanged: {
            root.targetColor.b = value
        }
    }

    Rectangle {
        width:32
        height:32
        border.width: 1
        border.color: mainWindow.palette.text
        color: root.targetColor
        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorDialog.visible = true
            }

        }
    }

    ColorDialog {
        id: colorDialog
        title: "Choose a color"
        onAccepted: {
            root.targetColor = colorDialog.selectedColor
        }
    }

    Label {
        text: "Opacity"
    }
    Slider {
        width: root.width - 2 * mainWindow.theme.mediumPadding
        value: root.targetOpacity
        enabled: root.enabled
        from: 0
        to: 1.0
        onValueChanged: {
            root.targetOpacity = value
        }
    }

}





