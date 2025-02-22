// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick

Item {
    id: handle

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

        onDraggingChanged: {
            if (!dragging) {
                document.updateCurrentSlide()
                handle.parent.checkDimensions()
            }
        }
    }
    z: parent.z + 1
}
