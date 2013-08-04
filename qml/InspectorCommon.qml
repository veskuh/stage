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


Column {

    property string title: ""

    Label {
        text: title
    }

    Label {
        text: "X"
    }

    TextField {
        text: inspector.target? inspector.target.x : ""
        validator: IntValidator { bottom: -1024; top: 1024 }
        enabled: inspector.target
        onAccepted: {
            inspector.target.x = parseInt(text)
        }
    }
    Label {
        text: "Y"
    }

    TextField {
        text: inspector.target? inspector.target.y : ""
        validator: IntValidator { bottom: -1024; top: 1024 }
        enabled: inspector.target
        onAccepted: {
            inspector.target.y = parseInt(text)
        }

    }

    Label {
        text: "Width"
    }

    TextField {
        text: inspector.target? inspector.target.width : ""
        validator: IntValidator { bottom: -1024; top: 1024 }
        enabled: inspector.target
        onAccepted: {
            inspector.target.width = parseInt(text)
        }
    }
    Label {
        text: "Height"
    }

    TextField {
        text: inspector.target? inspector.target.height : ""
        validator: IntValidator { bottom: -1024; top: 1024 }
        enabled: inspector.target
        onAccepted: {
            inspector.target.height = parseInt(text)
        }

    }
    Label {
        text: "Z"
    }

    Slider {
        minimumValue: 0
        maximumValue: 100
        stepSize: 1.0
        value: inspector.target? inspector.target.z : 0
        onValueChanged: {
            if (inspector.target) inspector.target.z = value
        }
    }

    Button {
        text: "Delete"
        onClicked: {
            var element  = inspector.target
            inspector.target = null
            element.destroy()
        }
    }
}
