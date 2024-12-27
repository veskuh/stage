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
            console.log("Shift click")
            // setup a multiselect
            // If target changes, check if currently already in multiselection
            // and add to existing multiselection
            // Otherwise create a new multiselection with previously selected object and
            // this one
            if (mainWindow.target !== target) {
                var group = content.getGroup()
                group.add(target)
                console.log("activate group")
                mainWindow.target = group
                mainWindow.inspectorSource = group.inspectorSource
            } // Just ignore if not different

        } if (mouse.button == Qt.RightButton) {
            contextMenu.popup()
        } else {
            mainWindow.target = target
            mainWindow.inspectorSource = source
            content.selectionGroup = null
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
