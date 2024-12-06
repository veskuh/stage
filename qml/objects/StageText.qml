// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

StageBase {
    inspectorSource: "TextInspector.qml"
    type: "StageText"
    property alias text: label.text
    property alias color: label.color
    property alias bold: label.font.bold
    property alias italic: label.font.italic
    property alias underline: label.font.underline
    property alias fontSize: label.font.pixelSize
    property alias fontName: label.font.family

    width: label.implicitWidth
    height: label.implicitHeight

    Label {
        id:label
        anchors.fill: parent
        text: "Hello World"
        color: "black"
        font.pixelSize: 36
    }

    function duplicate() {
        content.addObject({"type":"StageText","x": x + 10,"y": y + 10,"width":width,"height":height,"color":color,"text":text})
        content.deselect()
    }
}
