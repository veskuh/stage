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

Rectangle {
    id: inspector
    width: 300
  //  height: column.height
    color: palette.window
    property Item target: mainWindow.target

    Column {
        id: column
        padding: mainWindow.theme.mediumPadding
        spacing: mainWindow.theme.mediumPadding * 2

        Label {
            text: "Slides"
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
        }

        SeparatorLine {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
        }

        SlidePreview {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            slideTitle: "1"
        }

        SlidePreview {
            width: inspector.width - 2 * mainWindow.theme.mediumPadding
            slideTitle: "20"

        }



        StageToolButton {
            text: "New Slide"
            icon.source: theme.plusIcon
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Component.onCompleted: inspectorScrollView.contentHeight = column.height
}
