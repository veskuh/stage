// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {
    id: inspector
    property Item target: mainWindow.target
    color: palette.window

    Column {
        id: column
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding * 2

        InspectorCommon {
            title: "Circle"
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            text: "Color"
        }


        ColorPicker {
            width: inspector.width
            targetColor: inspector.target.color
            targetOpacity: inspector.target.opacity
            enabled: inspector.target
            onTargetColorChanged: inspector.target.color = targetColor
            onTargetOpacityChanged: inspector.target.opacity = targetOpacity
        }
    }
    Component.onCompleted: inspectorScrollView.contentHeight = column.height
}
