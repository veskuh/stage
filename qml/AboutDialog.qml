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
            text: "Stage"
            font.pointSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "© 2024 veskuh.net"
            font.pointSize: 12
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
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
