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

import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: inspector
    anchors.fill: parent
    color: palette.window
    property Item target: mainWindow.target

    Column {

        InspectorCommon {
            title: "Text"
        }

        Label {
            text: "Text"
        }

        TextField {
            text: inspector.target? inspector.target.text : ""
            enabled: inspector.target
            onTextChanged: {
                if (inspector.target) inspector.target.text = text
            }
        }
    }
}
