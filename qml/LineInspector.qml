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
