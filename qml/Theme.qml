// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQml
import QtQuick.Controls

QtObject {
    id: theme

    // Common Paddings
    property int smallPadding: (Qt.platform.os === "osx") ? 4 : 6
    property int mediumPadding: smallPadding * 2
    property int largePadding: mediumPadding * 2

    // Font Sizes
    property int smallFontSize: (Qt.platform.os === "osx") ? 12 : 14
    property int mediumFontSize: (Qt.platform.os === "osx") ? 14 : 16
    property int largeFontSize: (Qt.platform.os === "osx") ? 18 : 20

    // Tool symbols, on mac from SF Symbols
    property string selectSymbol: (Qt.platform.os === "osx") ? "􀮐" : ""
    property string rectSymbol: (Qt.platform.os === "osx") ? "􀏃" : ""
    property string circleSymbol: (Qt.platform.os === "osx") ? "􀀀" : ""
    property string textSymbol: (Qt.platform.os === "osx") ? "􀅶" : ""
    property string imageSymbol: (Qt.platform.os === "osx") ? "􀏅" : ""

    // Tool icons
    property string selectIcon: (Qt.platform.os === "osx") ? "image://macSymbol/cursorarrow.and.square.on.square.dashed" : "file:///usr/share/icons/breeze/actions/16/select-symbolic.svg"
    property string lineIcon: (Qt.platform.os === "osx") ? "image://macSymbol/line.diagonal" : "file:///usr/share/icons/breeze/actions/16/draw-line-symbolic.svg"
    property string rectIcon: (Qt.platform.os === "osx") ? "image://macSymbol/square" : "file:///usr/share/icons/breeze/actions/16/draw-rectangle-symbolic.svg"
    property string circleIcon: (Qt.platform.os === "osx") ? "image://macSymbol/circle" : "file:///usr/share/icons/breeze/actions/16/draw-circle-symbolic.svg"
    property string textIcon: (Qt.platform.os === "osx") ? "image://macSymbol/character.textbox" : "file:///usr/share/icons/breeze/actions/16/draw-text-symbolic.svg"
    property string imageIcon: (Qt.platform.os === "osx") ? "image://macSymbol/photo" : "file:///usr/share/icons/breeze/actions/16/insert-image-symbolic.svg"
    property string playIcon: (Qt.platform.os === "osx") ? "image://macSymbol/play.rectangle" : "file:///usr/share/icons/breeze/actions/16/media-playback-start-symbolic.svg"
    property string slidesIcon: (Qt.platform.os === "osx") ? "image://macSymbol/rectangle.on.rectangle" : "file:///usr/share/icons/breeze/actions/16/media-playback-start-symbolic.svg"
    property string inspectorIcon: (Qt.platform.os === "osx") ? "image://macSymbol/slider.horizontal.3" : "file:///usr/share/icons/breeze/actions/16/media-playback-start-symbolic.svg"
    property string plusIcon: (Qt.platform.os === "osx") ? "image://macSymbol/plus.rectangle" : "file:///usr/share/icons/breeze/actions/16/media-playback-start-symbolic.svg"


}

