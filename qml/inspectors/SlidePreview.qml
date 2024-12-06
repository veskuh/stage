// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>
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
        }

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
            document.showSlide(index)
        }
    }
}
