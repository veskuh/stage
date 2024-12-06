// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls 1.2


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


