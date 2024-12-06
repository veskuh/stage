// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    id: aboutWindow
    title: "About Stage"
    width: 600
    height: 400
    visible: false

    SystemPalette {id: palette}

    Rectangle {
        anchors.fill: parent
        color: palette.window
    }

    Column {
        spacing: 20
        anchors.centerIn: parent

        Image {
            source: "../assets/stage.png"
            width: 128
            height: 128
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            color: palette.text
            text: "Stage"
            font.pointSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            color: palette.text
            text: "© 2024 veskuh.net"
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            color: palette.text
            text: "This is a simple presentation program. <br> License: GPLv2. <br>Sources: <a href=\"https://github.com/veskuh/stage\">https://github.com/veskuh/stage</a>"
            wrapMode: Text.WordWrap
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: aboutWindow.width - 2 * 20
            onLinkActivated: (link) => Qt.openUrlExternally(link)
        }
    }

    Component.onCompleted: {
        aboutWindow.x = Screen.width / 2 - aboutWindow.width / 2
        aboutWindow.y = Screen.height / 2 - aboutWindow.height / 2
    }
}
