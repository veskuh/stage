// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "../"

Rectangle {
    id: inspector
    width: 300
    color: palette.window
    property Item target: mainWindow.target

    ListView {
        id: list
        width: parent.width
        height: parent.height - 100
        model: document.slideModel

        delegate: SlidePreview {
            width: list.width
            source: "image://slideProvider/" + imageId
            slideTitle: (index+1) + "."
        }
    }
}
