// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick

StageBase {
    type: "StageCircle"
    inspectorSource: "CircleInspector.qml"
    property alias color: rect.color
    width: 100
    height: 100

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "blue"
        radius: (width + height) / 2
    }

    function duplicate() {
        content.addObject({"type":"StageCircle","x": x + 10,"y": y + 10,"width":width,"height":height,"color":color})
        content.deselect()
    }
}
