// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

ToolButton {
    id: button
    checkable: true
    icon.width: 32
    icon.height: (Qt.platform.os === "osx") ? 26 : 32

    display: icon.source != "" ? AbstractButton.TextUnderIcon : AbstractButton.TextOnly
}
