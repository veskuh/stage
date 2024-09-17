/*
Stage - a simple presentation application
Copyright (C) 2024 Vesa-Matti Hartikainen <vesku.h@gmail.com>

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
import QtQuick.Dialogs
import Qt.labs.platform as Labs
import "../js/menucommands.js" as MenuCommands
import "../js/utils.js" as Utils

Labs.MenuBar {
    Labs.Menu {
        Labs.MenuItem {
            text: "About Stage"
            role: Labs.MenuItem.AboutRole
            onTriggered: aboutDialog.visible = true
        }

        /* todo
        Labs.MenuItem {
            role: Labs.MenuItem.PreferencesRole
            text:"Preferences"
            onTriggered: console.log("Preferences")
        }*/


        title: "&File"

        Labs.MenuItem {
            text: "&New"
            shortcut: StandardKey.New
            onTriggered: MenuCommands.close()
        }
        Labs.MenuItem {
            text: "&Open"
            shortcut: StandardKey.Open
            onTriggered: MenuCommands.open()
        }
        Labs.MenuSeparator { }

        Labs.MenuItem {
            text: "&Close"
            shortcut: StandardKey.Close
            onTriggered: MenuCommands.close()
        }

        Labs.MenuItem {
            text: "&Save"
            shortcut: StandardKey.Save
            onTriggered: MenuCommands.save()
        }
        Labs.MenuItem {
            text: "Save As.."
            onTriggered: MenuCommands.saveAs()
        }

        Labs.MenuItem {
            text: "&Close"
            shortcut: StandardKey.Close
            onTriggered: MenuCommands.close()
        }
        Labs.MenuSeparator { }

        Labs.MenuItem {
            text: "Export SVG.."
            onTriggered: MenuCommands.exportSvg()
        }
    }
    Labs.Menu {
        title: "Edit"
        Labs.MenuItem {
            text: "Cut"
            enabled: target && Utils.canCopy(mainWindow.editItem)
            shortcut: StandardKey.Cut
            onTriggered: MenuCommands.cut()
        }
        Labs.MenuItem {
            text: "Copy"
            enabled: target && Utils.canCopy(mainWindow.editItem)
            shortcut: StandardKey.Copy
            onTriggered: MenuCommands.copy()
        }
        Labs.MenuItem {
            text: "Paste"
            enabled: clipboard.clipboardText!=""
            shortcut: StandardKey.Paste
            onTriggered: MenuCommands.paste()
        }
        Labs.MenuItem {
            text: "Delete"
            enabled: target
            shortcut: StandardKey.Delete
            onTriggered: MenuCommands.deleteTarget()
        }
        Labs.MenuSeparator {}
        Labs.MenuItem {
            text: "Duplicate"
            enabled: target
            // shortcut: StandardKey.Delete
            onTriggered: MenuCommands.duplicateTarget()
        }
        Labs.MenuSeparator {}
        Labs.MenuItem {
            text: "Deselect"
            enabled: target
            shortcut: StandardKey.Deselect
            onTriggered: MenuCommands.deselect()
        }
        Labs.MenuItem {
            text: "Select All"
            enabled: true
            shortcut: StandardKey.SelectAll
            onTriggered: MenuCommands.selectAll()
        }

    }

    Labs.Menu {
        title: "Arrange"
        Labs.MenuItem {
            text: "Hide"
            enabled: target && target.visible
            onTriggered: MenuCommands.setVisible(false)
        }
        Labs.MenuItem {
            text: "Unhide"
            enabled: target && !target.visible
            onTriggered: MenuCommands.setVisible(true)
        }
        Labs.MenuSeparator { }
        Labs.MenuItem {
            text: "Lock"
            enabled: target && target.enabled
            onTriggered: MenuCommands.setLocked(true)
        }
        Labs.MenuItem {
            text: "Unlock"
            enabled: target && !target.enabled
            onTriggered: MenuCommands.setLocked(false)
        }
        Labs.MenuSeparator { }
        Labs.MenuItem {
            text: "Bring Forward"
            enabled: target
            onTriggered: MenuCommands.forward()
        }
        Labs.MenuItem {
            text: "Send Backward"
            enabled: target
            onTriggered: MenuCommands.backward()
        }
    }
    Labs.Menu {
        title: "View"
        Labs.MenuItem {
            text: "Zoom In"
            onTriggered: MenuCommands.zoomIn()
        }

        Labs.MenuItem {
            text: "Zoom Out"
            onTriggered: MenuCommands.zoomOut()
        }

        Labs.MenuItem {
            text: "Actual size"
            onTriggered: MenuCommands.actualSize()
        }
    }
}
