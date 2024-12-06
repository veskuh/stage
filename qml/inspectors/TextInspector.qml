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
                objectName: "TextInput"
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
