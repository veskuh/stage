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
        spacing: mainWindow.theme.mediumPadding * 2

        InspectorCommon {
            title: "Image"
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            text: "Source file"
        }

        Label {
            text: inspector.target? inspector.target.url : "No source"
            elide: Text.ElideLeft
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }
        Button {
            text: "Change source.."
            onClicked: {
                inspector.target.dialog.visible = true
            }
        }
    }
    Component.onCompleted: inspectorScrollView.contentHeight = column.height
}
