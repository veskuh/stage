// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQml
import QtQuick.Controls
import "../"

StageBase {
    inspectorSource: "GroupInspector.qml"
    id: base

    type:"Group"

    visible: true
    contextMenu: groupMenu

    property list<StageBase> members
    property bool activeSelection: mainWindow.target === base

    ContextMenuCommon {
        id: groupMenu


        Menu {
            title: "Align object"
            MenuItem {
                text: "Top"
                onTriggered: base.alignToTop()
            }
            MenuItem {
                text: "Bottom"
                onTriggered: base.alignToBottom()
            }

            MenuItem {
                text: "Left"
                onTriggered: base.alignToLeft()
            }

            MenuItem {
                text: "Right"
                onTriggered: base.alignToRight()
            }

        }
    }

    function alignToTop() {
        var smallest = members[0].y
        iterateMembers( member => { if (member.y < smallest) { smallest = member.y } })
        iterateMembers( member => member.y = smallest)
    }

    function alignToBottom() {
        var largest = members[0].y + members[0].height
        iterateMembers( member => { if ((member.y + member.height) > largest) { largest = member.y + member.height } })
        iterateMembers( member => member.y = largest-member.height )
    }

    function alignToLeft() {
        var smallest = members[0].x
        iterateMembers( member => { if (member.x < smallest) { smallest = member.x } })
        iterateMembers( member => member.x = smallest)
    }

    function alignToRight() {
        var largest = members[0].x + members[0].width
        iterateMembers( member => { if ((member.x + member.widht) > largest) { largest = member.x + member.width } })
        iterateMembers( member => member.x = largest - member.width)
    }

    function add(target) {
        members.push(target)
        target.group = base
    }

    function clear() {
        for(var member in members){
            if (members[member]!=null) {
                if (members[member].group === base) {
                    members[member].group = null
                }
            }
        }
        member = []
    }

    function iterateMembers(callback) {
        for(var member in members){
            if (members[member]!=null) {
                callback(members[member])
            }
        }
    }

    onVisibleChanged: {
        iterateMembers( member => member.visible = base.visible )
    }

    onEnabledChanged: {
        iterateMembers( member => member.enabled = base.enabled )
    }

    function forward() {
        iterateMembers( member => member.forward() )
    }

    function backward() {
        iterateMembers( member => member.backward() )
    }

    function duplicate() {
        iterateMembers( member => member.duplicate() )
    }

    Component.onDestruction: {
        for(var member in members){
            if (members[member]!=null) {
                members[member].destroy()
                members[member] = null
            }
        }
    }
}
