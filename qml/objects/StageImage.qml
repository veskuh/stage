// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

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
