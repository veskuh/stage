// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Shapes
import "../"

StageBase {
    id: base
    inspectorSource: "LineInspector.qml"
    type: "StageLine"
    property alias color: path.strokeColor
    width: 100
    height: 62
    baseDragAreaEnabled: false

    Shape {
        ShapePath {
            id: path
            strokeColor: "black"
            strokeWidth: content.scale < 1 ? 1.0/content.scale : 1.0 // We want 1 as stroke for lines to be visible
            startX: 0; startY: 0;
            PathLine { x: base.width; y: base.height; }
        }
    }

    StageMouseArea {
        id: dragArea
        source: base.inspectorSource
        x: 0
        y: -5
        width: Math.sqrt(base.width ** 2 + base.height ** 2)
        height: 10

        rotation: Math.atan2(base.height, base.width) * (180 / Math.PI);
        transformOrigin: Item.Left
        drag.target: parent
        target: base
    }

    function duplicate() {
        console.log("Duplicate")
        content.addObject({"type":"StageLine","x": x + 10,"y": y + 10,"width":width,"height":height,"color":color})
        mainWindow.target = null
    }
}
