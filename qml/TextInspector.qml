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

Rectangle {
    id: inspector
    color: palette.window
    property Item target: mainWindow.target

    Column {
        id: column
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding 

        InspectorCommon {
            title: "Text"
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        Column {
            spacing: mainWindow.theme.mediumPadding

            SectionHeader {
                text: "Text"
            }

            TextField { 
                width: inspector.width - 2 * mainWindow.theme.mediumPadding
                text: enabled ? inspector.target.text : ""
                enabled: inspector.target && target.inspectorSource == "TextInspector.qml" 
                onTextChanged: {
                    if (enabled) inspector.target.text = text
                }
            }

            TextField {
                width: inspector.width - 2 * mainWindow.theme.mediumPadding
                text: enabled ? inspector.target.fontName : ""
                enabled: inspector.target && target.inspectorSource == "TextInspector.qml"
                onAccepted: {
                    if (enabled) inspector.target.fontName = text
                }
            }

            NumberInput {
                labelText: "Font size"
                width: inspector.width - 2 * mainWindow.theme.mediumPadding
                enabled: inspector.target
                valueText: inspector.target? inspector.target.fontSize : ""

                onAccepted: (text) =>  {
                    inspector.target.fontSize = text
                }
            }

            Column {
                CheckBox {
                    checked: inspector.target.bold
                    text:  "Bold"
                    onClicked: inspector.target.bold = !inspector.target.bold
                }

                CheckBox {
                    checked: inspector.target.italic
                    text:  "Italic"
                    onClicked: inspector.target.italic = !inspector.target.italic
                }

                CheckBox {
                    checked: inspector.target.underline
                    text:  "Underline"
                    onClicked: inspector.target.underline = !inspector.target.underline
                }
            }
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            text: "Font color"
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
