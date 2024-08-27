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

StageBase {
    inspectorSource: "TextInspector.qml"
    property alias text: label.text
    property alias color: label.color
    property alias bold: label.font.bold
    property alias italic: label.font.italic
    property alias underline: label.font.underline
    property alias fontSize: label.font.pixelSize
    property alias fontName: label.font.family

    width: label.implicitWidth
    height: label.implicitHeight

    Label {
        id:label
        anchors.fill: parent
        text: "Hello World"
        color: "black"
        font.pixelSize: 36
    }

    function duplicate() {
        content.addObject({"type":"StageText","x": x + 10,"y": y + 10,"width":width,"height":height,"color":color,"text":text})
        content.deselect()
    }
}
