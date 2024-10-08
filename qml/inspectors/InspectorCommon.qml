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
import "../"


Column {
    property string title: ""
    property bool showSize: true
    width: inspector.width
    spacing: mainWindow.theme.mediumPadding

    Label {
        text: title
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
    }

    SeparatorLine {
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
    }

    SectionHeader {
        text: "Position"
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
    }

    NumberInput {
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
        labelText: "x:"
        enabled: inspector.target
        valueText: inspector.target? inspector.target.x.toFixed(0) : ""

        onAccepted: (text) =>  {
            inspector.target.x = text
        }
    }

    NumberInput {
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
        labelText: "y:"
        enabled: inspector.target
        valueText: inspector.target? inspector.target.y.toFixed(0) : ""

        onAccepted: (text) =>  {
            inspector.target.y = text
        }
    }

    SeparatorLine {
        visible: showSize
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
    }

    SectionHeader {
        visible: showSize
        text: "Size"
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
    }

    NumberInput {
        visible: showSize
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
        labelText: "Width:"
        enabled: inspector.target
        valueText: inspector.target? inspector.target.width.toFixed(0) : ""

        onAccepted: (text) =>  {
            inspector.target.width = text
        }
    }

    NumberInput {
        visible: showSize
        width: inspector.width - 2 * mainWindow.theme.mediumPadding
        labelText: "Height:"
        enabled: inspector.target
        valueText: inspector.target? inspector.target.height.toFixed(0) : ""

        onAccepted: (text) =>  {
            inspector.target.height = text
        }
    }

    Column {
        CheckBox {
            checked: !inspector.target.visible
            text: "Hide"
            onCheckedChanged: inspector.target.visible = !checked
        }

        CheckBox {
            checked: !inspector.target.enabled
            text: "Lock"
            onCheckedChanged: inspector.target.enabled = !checked
        }
    }
}
