// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQml
import "../"

StageBase {
    inspectorSource: "GroupInspector.qml"
    id: root

    type:"Group"

    visible: true

    property list<StageBase> members
    property bool activeSelection: mainWindow.target === root

    function add(target) {
        members.push(target)
        target.group = root
    }

    function clear() {
        for(var member in members){
            if (members[member]!=null) {
                if (members[member].group === root) {
                    members[member].group = null
                }
            }
        }
        member = []
    }

    function duplicate() {
        for(var member in members){
            if (members[member]!=null) {
               members[member].duplicate()
            }
        }
    }

    function iterateMembers(callback) {
        for(var member in members){
            if (members[member]!=null) {
                callback(members[member])
            }
        }
    }

    onVisibleChanged: {
        iterateMembers( member => member.visible = root.visible )
    }

    onEnabledChanged: {
        iterateMembers( member => member.enabled = root.enabled )
    }

    function forward() {
        iterateMembers( member => member.forward() )
    }

    function backward() {
        iterateMembers( member => member.backward() )
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
