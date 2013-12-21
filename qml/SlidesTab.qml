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

import QtQuick 2.2
import QtQuick.Controls 1.1


Item {
    anchors.fill: parent

    ListModel {
        id: slideListModel
        ListElement { slide: "1" }
    }


    Label {
        id: tableLabel
        text: "Slide"
    }

    TableView {
        id: slideSelection
        anchors {
            top: tableLabel.bottom
            left: parent.left
            right: parent.right
            bottom: tableControls.top
        }

        TableViewColumn { role: "slide"; title: "Slide" }
        model: slideListModel
    }
    Row {
        id: tableControls
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        Button {
            text: "Add slide"
            onClicked: {
                var next = parseInt(slideListModel.get(slideListModel.count-1).slide) + 1
                slideListModel.append({"slide" : next.toString()})
                //TODO real add
            }
        }
        Button {
            text: "Remove"
            enabled: slideListModel.count > 1
            onClicked: {
                slideSelection.selection.forEach( function(rowIndex) {
                    slideSelection.selection.deselect(rowIndex)
                    slideListModel.remove(rowIndex)}
                )
                slideSelection.selection.select(0)
            }
        }
    }
    Component.onCompleted: slideSelection.selection.select(0)
}


