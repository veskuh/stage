/*
Stage - a simple presentation application
Copyright (C) 2013 Vesa-Matti Hartikainen <vesku.h@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Column {
    id: root
    property color targetColor
    property bool enabled: false

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
}





