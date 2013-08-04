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

import QtQuick 2.0

Rectangle {
    id: anchorLine

    property bool vertical: true
    property int location: 0
    property bool enabled: true

    x: vertical ? location : 0
    y: vertical ? 0 : location
    width: vertical ? 1.0 :  mainWindow.view.width
    height: vertical ? mainWindow.view.height : 1.0

    color: "blue"
    z: 1000

    property bool freeOrActive: vertical? !mainWindow.verticalAnchor || mainWindow.verticalAnchor == anchorLine : !mainWindow.horizontalAnchor || mainWindow.horizontalAnchor == anchorLine
    visible: enabled && mainWindow.draggedObject && match() && freeOrActive

    function match() {
        var retval = false
        var dragged = mainWindow.draggedObject

        if (vertical) {
            if (Math.abs(dragged.x - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.x + dragged.width - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.x + dragged.width / 2 - location) < 10 ){
                return true
            }

        } else {
            if (Math.abs(dragged.y - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.y + dragged.height - location) < 10 ){
                return true
            }
            if (Math.abs(dragged.y + dragged.height / 2 - location) < 10 ){
                return true
            }
        }


        return retval
    }

    onVisibleChanged: {
        if (vertical) {
            mainWindow.verticalAnchor = visible ? anchorLine : null
        } else {
            mainWindow.horizontalAnchor = visible? anchorLine : null
        }
    }

}
