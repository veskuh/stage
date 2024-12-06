// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import "../"

StageBase {
    inspectorSource: "RectInspector.qml"
    type: "StageRect"
    property alias color: rect.color
    width: 100
    height: 62

    Rectangle {
        id: rect
        anchors.fill: parent
        color: "blue"
    }

    function duplicate() {
        console.log("Duplicate")
        content.addObject({"type":"StageRect","x": x + 10,"y": y + 10,"width":width,"height":height,"color":color})
        mainWindow.target = null
    }
}
