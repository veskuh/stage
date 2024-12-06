// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

Rectangle {
    id: inspector
    anchors.fill: parent
    color: palette.window

    property Item target: mainWindow.target

    Column {
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding

        Label {
            text: "Group"
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SectionHeader {
            text: "Items"
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        Repeater {
            id: list
            property int lastSelection: -1

            model: ListModel {
                id: model
                dynamicRoles: true
            }

            Label {
                text: (index+1) + ". " + lockedSymbol() + name.replace(/\Inspector.qml$/, "").replace("Stage","")
                font.bold: index == list.lastSelection
                opacity: ref && ref.visible? 1.0 : 0.5

                MouseArea {
                    onClicked: {
                        mainWindow.target = ref
                        list.lastSelection = index
                    }
                    anchors.fill: parent
                }

                function lockedSymbol() {
                    const lockSymbol = ' \u{1F512} ';
                    return ref && ref.enabled ? "" : lockSymbol
                }
            }
        }
    }

    Component.onCompleted: {
        model.clear()
        var group = content.getGroup()
        var members = group.members
        if (members!=null) {
            for(var i in members){
                var member = members[i]
                var name = member.type != "" ? member.type : member.inspectorSource
                model.append({"name" : name, "ref": member})
            }
        }
    }
}
