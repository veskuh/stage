// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

Rectangle {
    id: inspector
    color: palette.window

    property Item target: mainWindow.target

    Column {
        id:column
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding

        InspectorCommon {
            title: "Image"
            showSize: false
        }
        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            text: "Size"
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        NumberInput {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            labelText: "Width:"
            enabled: inspector.target
            valueText: inspector.target? inspector.target.width.toFixed(0) : ""

            onAccepted: (text) =>  {
                inspector.target.setWidth(text)
            }
        }

        NumberInput {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            labelText: "Height:"
            enabled: inspector.target
            valueText: inspector.target? inspector.target.height.toFixed(0) : ""

            onAccepted: (text) =>  {
                inspector.target.setHeight(text)
            }
        }
    }
    Component.onCompleted: inspectorScrollView.contentHeight = column.height
}
