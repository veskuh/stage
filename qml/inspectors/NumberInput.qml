// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Controls

Item {
    id: root

    height: value.height
    property alias labelText: label.text
    property alias enabled: value.enabled
    property alias valueText: value.text
    signal accepted(text: string)

    Label {
        id: label
        anchors.verticalCenter: value.verticalCenter
    }

    TextField {
        id: value
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width - label.width - mainWindow.theme.smallPadding
        validator: IntValidator { bottom: -1024; top: 1024 }
        onAccepted: {
            root.accepted(parseInt(text))
        }
    }
}
