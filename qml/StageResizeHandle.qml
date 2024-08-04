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

Item {
    id: handle
    visible: parent.selected

    property Item dragTarget
    property real initialWidth
    property real initialHeight


    x: parent.width - width/2
    y: parent.height - height/2

    width: 11
    height: 11

    Rectangle {
        id: indicator

        width: mainWindow.theme.smallPadding
        height: 5
        color: "red"
        anchors.centerIn: parent
    }

    MouseArea {
        id: dragArea
        drag.target: handle
        anchors.fill: parent
        property bool dragging: drag.active

        onMouseXChanged: {
            if(dragging) {
                var x = handle.x
                handle.parent.width = x + handle.width/2
            }
        }

        onMouseYChanged: {
            if(dragging) {
                var y = handle.y
                handle.parent.height = y + handle.height/2
            }
        }
    }
    z: parent.z + 1
}
