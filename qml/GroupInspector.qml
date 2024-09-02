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
                text: index + " " + name.replace(/\Inspector.qml$/, "").replace("Stage","")

                font.bold: index == list.lastSelection

                MouseArea {
                    onClicked: {
                        mainWindow.target = ref
                        list.lastSelection = index
                    }
                    anchors.fill: parent
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("1")
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
        console.log("Complete")
    }
}
