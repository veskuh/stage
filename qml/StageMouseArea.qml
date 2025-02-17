// SPDX-License-Identifier: GPL-2.0+
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

MouseArea {
    id: root
    property Item target
    property string source: ""
    property bool dragging: drag.active

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    enabled: mainWindow.select

    onClicked: (mouse) => {
        if (mouse.modifiers & Qt.ShiftModifier) {
            mainWindow.addToGroup(target)
        } else if (mouse.button == Qt.RightButton) {
            activeObject().contextMenu.popup()
        } else {
            mainWindow.selectObject(target,source)
        }
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
            document.updateCurrentSlide()
            mainWindow.draggedObject = null
            parent.anchorLinesEnabled = true
        }
    }
}
