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

Item {
    id: base

    property alias inspectorSource: dragArea.source
    property bool selected: false

    property bool anchorLinesEnabled: true
    opacity: dragArea.drag.active? 0.5 : 1.0

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

    Component.onCompleted: {
        var component = Qt.createComponent("AnchorLine.qml")
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
}
