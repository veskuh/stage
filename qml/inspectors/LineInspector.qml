// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "../"

Rectangle {
    id: inspector
    width: 300
    height: column.height
    color: palette.window
    property Item target: mainWindow.target

    Column {
        id: column
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding
        InspectorCommon {
            title: "Line"
            showSize: false
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            text: "Details"
        }


        Item {
            id: row
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            height: label.height
            Label {
                id: label
                text: "Angle: " + slider.value.toFixed(0)
            }

            Slider {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                id:slider
                width: column.width / 2
                value: inspector.target? (Math.atan2(inspector.target.height, inspector.target.width) * (180 / Math.PI))+180 : 0
                from: 0
                to: 360
                onValueChanged: {
                    var length = Math.sqrt(inspector.target.width ** 2 + inspector.target.height ** 2 )
                    var angle = (value - 180.0) * (Math.PI / 180.0)
                    inspector.target.width = Math.cos(angle)*length
                    inspector.target.height = Math.sin(angle)*length
                }
            }
        }

        NumberInput {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            labelText: "Length:"
            enabled: inspector.target
            valueText: inspector.target? Math.sqrt(inspector.target.width ** 2 + inspector.target.height ** 2 ).toFixed(0) : ""

            onAccepted: (text) =>  {
                            var length = parseInt(valueText)
                            var angle = Math.atan(inspector.target.height/ inspector.target.width)
                            inspector.target.width = Math.cos(angle)*length
                            inspector.target.height = Math.sin(angle)*length
                        }
        }


        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
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
    Component.onCompleted: inspectorScrollView.contentHeight = height
}
