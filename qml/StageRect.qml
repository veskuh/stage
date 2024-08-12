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

StageBase {
    inspectorSource: "RectInspector.qml"
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
