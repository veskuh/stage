// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>
import QtQuick
import QtQuick.Controls
import "../"

Item {
    id: base
    height: (1080 / 1920) * width
    property alias slideTitle: slideNumber.text
    property bool selected: document.currentSlideIndex == index
    property alias source: preview.source

    Label {
        id: slideNumber
    }

    Image {
        id: preview
        x: theme.largePadding + theme.mediumPadding
        width: base.width - x - theme.largePadding
        height: (1080 / 1920) * width
        source: "image://slideProvider/" + imageId
        fillMode: Image.PreserveAspectFit
    }


    Rectangle {
        x: preview.x
        width: preview.width
        height: preview.height
        color:"transparent"
        antialiasing: true
        border.width: base.selected ? 3 : 0
        border.color: "grey"
    }

    MouseArea {
        anchors.fill: parent
        onEntered: opacity = 0.5
        onExited: opacity = 1.0
        onClicked: {
            document.showSlide(index)
        }
    }
}
