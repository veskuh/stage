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

    visible: false

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

    Component.onDestruction: {
        for(var member in members){
            if (members[member]!=null) {
                members[member].destroy()
                members[member] = null
            }
        }
    }
}
