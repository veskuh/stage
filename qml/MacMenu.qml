// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

import QtQuick
import QtQuick.Dialogs
import Qt.labs.platform as Labs
import "../js/menucommands.js" as MenuCommands
import "../js/utils.js" as Utils

Labs.MenuBar {
    id: menu
    property list<string> recents
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
        Labs.Menu {
            id: recentMenu
            title: "Recents"

            Instantiator {
                model: menu.recents
                Labs.MenuItem {
                    text: " " + modelData
                    onTriggered: {
                        mainWindow.filepath = modelData
                        document.load(modelData)
                    }
                }

                onObjectAdded: (index, object) => {
                                   if (object!=null && object!="") {
                                       console.log(""+object)
                                       recentMenu.insertItem(index, object)
                                   }
                               }
            }
            Labs.MenuSeparator { }

            Labs.MenuItem {
                text: "Clear"
                onTriggered: settings.recents.length = 0
            }

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
            enabled: clipboard.clipboardText!="" || clipboard.hasImage()
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
        title: "Slide"
        Labs.MenuItem {
            text: "Add slide"
            onTriggered: MenuCommands.addSlide()
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
            text: "Zoom to Fit"
            onTriggered: MenuCommands.scaleToFit()
        }

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

        Labs.MenuItem {
            text: "Present In Window"
            onTriggered: MenuCommands.togglePresent()
            checkable: true
        }
    }
}
