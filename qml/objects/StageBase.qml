// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import "../"

Item {
    id: base
    objectName: "StageBase"

    property alias inspectorSource: dragArea.source

    property QtObject group
    property bool selected: mainWindow.target === base || group && group.activeSelection

    property bool anchorLinesEnabled: true
    property string type: ""
    opacity: dragArea.drag.active? 0.5 : 1.0

    property alias baseDragAreaEnabled : dragArea.enabled

    Menu {
        id: contextMenu
        MenuItem {
            text: "Delete"
            onTriggered: base.destroy()
        }
        MenuItem {
            text: "Duplicate"
            onTriggered: base.duplicate()
        }
        MenuItem {
            text: "Hide"
            onTriggered: base.visible = false
        }
        MenuItem {
            text: "Lock"
            onTriggered: base.enabled = false
        }
        MenuItem {
            text: "Bring forward"
            onTriggered: base.z+=1
        }
        MenuItem {
            text: "Send backward"
            onTriggered: base.z-=1
        }
    }

    StageMouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        target: base
    }

    property AnchorLine leftLine
    property AnchorLine verticalCenterLine
    property AnchorLine rightLine
    property AnchorLine topLine
    property AnchorLine bottomLine
    property AnchorLine horizontalCenterLine
    property bool inDragGroup : enabled &&
                                mainWindow.draggedObject &&
                                group &&
                                mainWindow.draggedObject !== base &&
                                mainWindow.draggedObject.group == group &&
                                updateDrag()

    property int deltaX
    property int deltaY
    property bool dragStart: false

    onInDragGroupChanged: {
        if(!inDragGroup) {
            dragStart = false
        }
    }

    function updateDrag() {
        if (mainWindow.draggedObject) {
            if(!dragStart) {
                base.deltaX = base.x - mainWindow.draggedObject.x
                base.deltaY = y - mainWindow.draggedObject.y
                dragStart = true

            } else {
                base.x = (mainWindow.draggedObject.x+base.deltaX)
                base.y = (mainWindow.draggedObject.y+base.deltaY)
            }
            return true
        }
        return false
    }


    Component.onCompleted: {
        var component = Qt.createComponent("../AnchorLine.qml")
        leftLine = component.createObject(mainWindow.view, {"vertical": true,
                                              "location": Qt.binding(function() { return x}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
        verticalCenterLine = component.createObject(mainWindow.view, {"vertical": true,
                                              "location": Qt.binding(function() { return x + width/2}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
        rightLine = component.createObject(mainWindow.view, {"vertical": true,
                                              "location": Qt.binding(function() { return x + width}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
        topLine = component.createObject(mainWindow.view, {"vertical": false,
                                              "location": Qt.binding(function() { return y}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
        horizontalCenterLine = component.createObject(mainWindow.view, {"vertical": false,
                                              "location": Qt.binding(function() { return y + height/2}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
        bottomLine = component.createObject(mainWindow.view, {"vertical": false,
                                              "location": Qt.binding(function() { return y + height}),
                                              "enabled": Qt.binding(function() {return anchorLinesEnabled})})
    }

    Component.onDestruction: {
        leftLine.destroy()
        verticalCenterLine.destroy()
        rightLine.destroy()
        topLine.destroy()
        bottomLine.destroy()
        horizontalCenterLine.destroy()
    }

    StageResizeHandle {
    }

    SelectionHighlight {
        width: parent.width
        height: parent.height

        visible: selected && dragArea.enabled
    }

    function duplicate() {
        console.log("Warning: duplicate not implemented")
    }
}
