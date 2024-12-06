// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

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
