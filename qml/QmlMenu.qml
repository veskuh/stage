// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick.Controls
import QtQuick
import QtQuick.Dialogs
import "../js/menucommands.js" as MenuCommands
import "../js/utils.js" as Utils

MenuBar {
    id: qmlMenu
    Menu {
        title: "&File"
        Action {
            text: "&New"
            shortcut: StandardKey.New
            onTriggered: MenuCommands.close()
        }
        Action {
            text: "&Open"
            shortcut: StandardKey.Open
            onTriggered: MenuCommands.open()
        }
        MenuSeparator {}
        Action {
            text: "&Close"
            shortcut: StandardKey.Close
            onTriggered: MenuCommands.close()
        }
        Action {
            text: "&Save"
            shortcut: StandardKey.Save
            onTriggered: MenuCommands.save()
        }
        Action {
            text: "Save As.."
            onTriggered: MenuCommands.saveAs()
        }
        MenuSeparator {}
        Action {
            text: "Export SVG.."
            onTriggered: MenuCommands.exportSvg()
        }

        MenuSeparator {}
        Action {
            text: "E&xit"
            shortcut: StandardKey.Quit
            onTriggered: {
                mainWindow.close()
            }
        }
    }

    Menu {
        title: "&Edit"
        Action {
            text: "Cut"
            enabled: target
                     && mainWindow.editItem
                     && mainWindow.editItem.selectedText !== ""
            shortcut: StandardKey.Cut
            onTriggered: MenuCommands.cut()
        }
        Action {
            text: "Copy"
            enabled: target
                     && mainWindow.editItem
                     && mainWindow.editItem.selectedText !== ""
            shortcut: StandardKey.Copy
            onTriggered: MenuCommands.copy()
        }
        Action {
            text: "Paste"
            enabled: mainWindow.editItem && mainWindow.editItem.canPaste === true
            shortcut: StandardKey.Paste
            onTriggered: MenuCommands.paste()
        }
        MenuSeparator {}
        Action {
            text: "Duplicate"
            enabled: target
            onTriggered: MenuCommands.duplicateTarget()
        }
        Action {
            text: "Delete"
            shortcut: StandardKey.Delete
            enabled: target
            onTriggered: MenuCommands.deleteTarget()
        }
        Action {
            text: "Select all"
            enabled: true
            shortcut: StandardKey.SelectAll
            onTriggered: MenuCommands.selectAll()
        }
        Action {
            text: "Deselect"
            enabled: target
            shortcut: StandardKey.Deselect
            onTriggered: MenuCommands.deselect()
        }
    }

    Menu {
        title: "&Arrange"
        Action {
            text: "Hide"
            enabled: target && target.visible
            onTriggered: MenuCommands.setVisible(false)
        }
        Action {
            text: "Unhide"
            enabled: target && !target.visible
            onTriggered: MenuCommands.setVisible(true)
        }
        Action {
            text: "Lock"
            enabled: target && target.enabled
            onTriggered: MenuCommands.setLocked(true)
        }
        Action {
            text: "Unlock"
            enabled: target && !target.enabled
            onTriggered: MenuCommands.setLocked(false)
        }
        Action {
            text: "Bring forward"
            enabled: target
            onTriggered: MenuCommands.forward()
        }
        Action {
            text: "Send backward"
            enabled: target
            onTriggered: MenuCommands.backward()
        }

    }

    Menu {
        title: "View"
        Action {
            text: "Zoom to Fit"
            onTriggered: MenuCommands.scaleToFit()
        }

        Action {
            text: "Zoom in"
            onTriggered: MenuCommands.zoomIn()
        }

        Action {
            text: "Zoom out"
            onTriggered: MenuCommands.zoomOut()
        }

        Action {
            text: "Actual size"
            onTriggered: MenuCommands.actualSize()
        }

        Action {
            text: "Present Fullscreen"
            onTriggered: mainWindow.showFullScreen()
        }

        Action {
            text: "Present In Window"
            onTriggered: MenuCommands.togglePresent()
            checkable: true
        }
    }

    Menu {
        title: "&Help"
        Action {
            text: "About Stage..."
            onTriggered:
                aboutDialog.visible = true
        }
    }
}
