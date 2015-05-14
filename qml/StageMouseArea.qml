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

import QtQuick 2.4

MouseArea {
    property Item target
    property string source: ""
    property bool dragging: drag.active

    enabled: mainWindow.select

    onClicked: {
        mainWindow.target = target
        mainWindow.inspectorSource = source
    }

    onDraggingChanged: {
        if(dragging) {
            parent.anchorLinesEnabled = false
            mainWindow.draggedObject = parent
        } else {
            var anchor, dc
            if (mainWindow.verticalAnchor) {
                anchor = mainWindow.verticalAnchor
                var dx = Math.abs(parent.x - anchor.location)
                var dw = Math.abs(anchor.location - (parent.x + parent.width))
                dc = Math.abs(anchor.location - (parent.x + parent.width/2))
                if (dx <= dc && dx <= dw ) {
                    parent.x = anchor.location
                } else if ( dw <= dx && dw <= dc) {
                    parent.x = anchor.location - parent.width
                } else {
                    parent.x = anchor.location - parent.width/2
                }
            }
            if (mainWindow.horizontalAnchor) {
                anchor = mainWindow.horizontalAnchor
                var dy = Math.abs(parent.y - anchor.location)
                var dh = Math.abs(anchor.location - (parent.y + parent.height))
                dc = Math.abs(anchor.location - (parent.y + parent.height/2))
                if (dy <= dc && dy <= dh ) {
                    parent.y = anchor.location
                } else if ( dh <= dy && dh <= dc) {
                    parent.y = anchor.location - parent.height
                } else {
                    parent.y = anchor.location - parent.height/2
                }
            }
            mainWindow.draggedObject = null
            parent.anchorLinesEnabled = true
        }
    }
}
