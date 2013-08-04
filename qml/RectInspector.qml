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

    property Item target: mainWindow.target
    color: palette.window


    Column {
        InspectorCommon {
            title: "Rectangle"
        }


        Label {
            text: "R"
        }
        Slider {
            value: inspector.target? inspector.target.color.r : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                inspector.target.color.r = value
            }
        }
        Label {
            text: "G"
        }
        Slider {
            value: inspector.target? inspector.target.color.g : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                if (inspector.target) inspector.target.color.g = value
            }
        }
        Label {
            text: "B"
        }
        Slider {
            value: inspector.target? inspector.target.color.b : 0
            enabled: inspector.target
            minimumValue: 0
            maximumValue: 1.0
            onValueChanged: {
                if (inspector.target) inspector.target.color.b = value
            }
        }
    }
}
