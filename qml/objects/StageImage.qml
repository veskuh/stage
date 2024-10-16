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
import QtQuick.Dialogs


StageBase {
    property alias dialog: fileDialog
    property alias url: image.source
    type: "StageImage"
    width: image.width
    height: image.height
    inspectorSource: "ImageInspector.qml"

    FileDialog {
        id: fileDialog
        title: "Choose image"
        fileMode: FileDialog.OpenFile
        nameFilters: [ "Image filels (*.jpg *.png)"]

        onAccepted: {
            image.source = fileDialog.currentFile
        }
    }

    Image {
        id: image
        scale: Math.min(parent.width / paintedWidth, parent.height / paintedHeight)
        transformOrigin: "TopLeft"
    }

    Component.onCompleted: {
        if (url == "") {
            fileDialog.visible = true
        }
    }

    function duplicate() {
        content.addObject({"type":"StageImage","x": x + 10,"y": y + 10,"width":width,"height":height,"url":url})
        content.deselect()
    }
}
