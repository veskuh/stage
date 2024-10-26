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
import QtQuick.Dialogs
import "../"

Item {
    id: base
    height: (1080 / 1920) * width
    property alias slideTitle: slideNumber.text
    property bool selected: false
    property alias source: image.source

    Label {
        id: slideNumber
    }

    Rectangle {

        Image {
            id:image
            width: base.width
            height: base.height
            source: "image://slideProvider/" + imageId
            fillMode: Image.PreserveAspectFit
        } /*
        Label {
            id: image
            text: source
            property string source: ""
        }*/


        x: theme.largePadding + theme.mediumPadding
        width: parent.width - x
        height: (1080 / 1920) * width
        color: base.selected? "white" : "gray"
        antialiasing: true
        border.width: base.selected ? 3 : 0
        border.color: "grey"

    }

    MouseArea {
        anchors.fill: parent

        onEntered: opacity = 0.5
        onExited: opacity = 1.0
        onClicked: {
            base.selected = !base.selected
            console.log("Got click")
        }
    }
}
