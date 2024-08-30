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
import QtQuick.Shapes

StageBase {
    id: base
    inspectorSource: "LineInspector.qml"
    property alias color: path.strokeColor

    width: 100
    height: 62

    baseDragAreaEnabled: false

    Shape {
        ShapePath {
            id: path
            strokeColor: "black"
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
