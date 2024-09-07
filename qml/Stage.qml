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

import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform as Labs
import com.mac.vesku.stage
import "../js/menucommands.js" as MenuCommands

ApplicationWindow {
    id: mainWindow

    property string state: "Ready"
    property Component factory
    property string inspectorSource
    property Item target
    property bool select: !factory
    property alias view: content
    property Item draggedObject
    property Item verticalAnchor
    property Item horizontalAnchor
    property url filepath

    width: 1024
    height: 768
    title: "Stage"

    property QtObject theme: Theme {

    }

    Settings {
        property alias x: mainWindow.x
        property alias y: mainWindow.y
        property alias width: mainWindow.width
        property alias height: mainWindow.height
    }

    Document {
        id: document
    }

    ListModel {
        id: textStyles

        ListElement {
            name: "Slide Heading"
            fontSize: 60
        }

        ListElement {
            name: "Slide body"
            fontSize: 35
        }
    }


    menuBar: Qt.platform.os == "osx" ? null : qmlMenu
    Labs.MenuBar {
        id: macMenu

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
            // This is annoying, shortcut is not properly shown in menu
            // Probably Qt bug / missing feature
            Labs.MenuItem {
                text: "&Open"
                shortcut: StandardKey.Open
                onTriggered: MenuCommands.open()

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
                text: "Export SVG.."
                onTriggered: MenuCommands.exportSvg()
            }
        }
        Labs.Menu {
            title: "Edit"
            Labs.MenuItem {
                text: "Duplicate"
                enabled: target
                // shortcut: StandardKey.Delete
                onTriggered: MenuCommands.duplicateTarget()
            }

            Labs.MenuSeparator { }

            Labs.MenuItem {
                text: "Delete"
                enabled: target
                shortcut: StandardKey.Delete
                onTriggered: MenuCommands.deleteTarget()
            }

            Labs.MenuSeparator { }

            Labs.MenuItem {
                text: "Select all"
                enabled: true
                onTriggered: MenuCommands.selectAll()
            }

            Labs.MenuItem {
                text: "Deselect"
                enabled: target
                onTriggered: MenuCommands.deselect()
            }
        }

        Labs.Menu {
            title: "Arrange"
            Labs.MenuItem {
                text: "Bring forward"
                enabled: target
                onTriggered: MenuCommands.forward()
            }
            Labs.MenuItem {
                text: "Send backward"
                enabled: target
                onTriggered: MenuCommands.backward()
            }
        }
        Labs.Menu {
            title: "View"
            Labs.MenuItem {
                text: "Zoom in"
                onTriggered: MenuCommands.zoomIn()
            }

            Labs.MenuItem {
                text: "Zoom out"
                onTriggered: MenuCommands.zoomOut()
            }

            Labs.MenuItem {
                text: "Actual size"
                onTriggered: MenuCommands.actualSize()
            }
        }
    }



    MenuBar {
        id: qmlMenu
        Menu {
            title: "&File"
            // This is annoying, shortcut is not properly shown in menu
            // Probably Qt bug / missing feature
            Action {
                text: "&Open"
                shortcut: StandardKey.Open
                onTriggered: MenuCommands.open()
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


    header: ToolBar {
        height: selectButton.height + theme.smallPadding * 2

        RowLayout {
            id: toolRow
            anchors.verticalCenter: parent.verticalCenter

            StageToolButton {
                id: selectButton
                text: "Select"
                icon.source: theme.selectIcon
                checked: factory == null
                onClicked: {
                    content.deselect()
                    factory = null
                    mainWindow.state = "Select"
                }
            }

            ToolSeparator {}

            StageToolButton {
                text: "Line"
                checked: mainWindow.state == "Line"
                icon.source: theme.lineIcon
                onClicked: toolRow.selectTool("StageLine.qml","Line")
            }

            StageToolButton {
                text: "Rectangle"
                checked: mainWindow.state == "Rectangle"
                icon.source: theme.rectIcon
                onClicked: toolRow.selectTool("StageRect.qml","Rectangle")
            }
            StageToolButton {
                text: "Circle"
                checked: mainWindow.state == "Circle"
                icon.source: theme.circleIcon
                onClicked: toolRow.selectTool("StageCircle.qml", "Circle")
            }
            StageToolButton {
                text: "Text"
                checked: mainWindow.state == "Text"
                icon.source: theme.textIcon
                onClicked: toolRow.selectTool("StageText.qml", "Text")
            }
            StageToolButton {
                text: "Image"
                checked: mainWindow.state == "Image"
                icon.source: theme.imageIcon
                onClicked: toolRow.selectTool("StageImage.qml", "Image")
            }

            function selectTool(factoryQmlName, state) {
                content.deselect()
                factory = Qt.createComponent(factoryQmlName)
                mainWindow.state = state
            }

        }
    }

    footer: ToolBar {
        RowLayout {
            Label { text: mainWindow.state }
        }
    }

    SystemPalette {id: palette}

    SplitView {
        anchors.fill: parent

        ScrollView {
            height: mainWindow.height
            SplitView.fillWidth: true
            contentWidth: content.width * content.scale + theme.largePadding * 2
            contentHeight: content.height * content.scale + theme.largePadding * 2

            Rectangle {
                id: content
                objectName: "contentRectangle"
                x: theme.largePadding
                y: theme.largePadding
                height: 1080
                width: 1920
                scale: 0.5
                anchors.top: parent.top
                anchors.left: parent.left
                transformOrigin: "TopLeft"


                property Group selectionGroup

                function addObject(properties) {
                    var component = Qt.createComponent(properties.type +".qml")
                    if (component.status == Component.Ready) {
                        component.createObject(content, properties)
                    } else {
                        console.log("Cannot create component for type: " + properties.type)
                    }
                }

                function clear() {
                    for (var child in content.children) {
                        if (content.children[child].objectName == "StageBase") {
                            content.children[child].destroy(10)
                        }
                    }
                }

                function selectAll() {
                    content.deselect()
                    var group = content.getGroup()
                    for (var child in content.children) {
                        var childObject = content.children[child]
                        if (childObject.type && childObject.type!="Group" && childObject.objectName == "StageBase") {
                            console.log("Adding to group")
                            group.add(content.children[child])
                        }
                    }
                    mainWindow.target = group
                    mainWindow.inspectorSource = group.inspectorSource
                }

                function deselect() {
                    if (target && content.selectionGroup) {
                        if (target.group) target.group.clear()
                        if (content.selectionGroup) content.selectionGroup.clear()
                        content.selectionGroup = null
                    }
                    target = null
                }

                function getGroup() {
                    if (selectionGroup == null) {
                        var component = Qt.createComponent("Group.qml")
                        if (component.status == Component.Ready) {
                            selectionGroup = component.createObject(content, {})
                        } else {
                            console.log("Cannot create component for type: " + properties.type)
                            return null
                        }

                        if (target) {
                            selectionGroup.add(target)
                        }
                    }
                    return selectionGroup
                }

                AnchorLine {
                    vertical: true
                    location: content.width/2
                }

                AnchorLine {
                    vertical: false
                    location: content.height/2
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (factory) {
                            factory.createObject(parent, {"x": mouseX, "y": mouseY})
                            factory = null
                            mainWindow.state = "Select"
                        } else {
                            content.deselect()
                        }
                    }
                }
            }
        }


        Pane {
            width:300
            height: mainWindow.height

            SplitView.preferredWidth: 250
            ScrollView {
                id: inspectorScrollView
                anchors.fill: parent

                Loader {
                    anchors.fill: parent
                    source: mainWindow.inspectorSource
                }

            }
        }
    }


    onTargetChanged: {
        if (!target) {
            inspectorSource = ""
        }
    }

    FileDialog {
        id: openDialog
        title: "Choose file"
        fileMode: FileDialog.OpenFile
        property bool exportSvg: false
        nameFilters: exportSvg? ["svg files (*.svg)"] : [ "json files (*.json)"]

        onAccepted: {
            filepath = openDialog.currentFile
            if (fileMode==FileDialog.OpenFile) {
                document.load(filepath)

            } else {
                if (!exportSvg) {
                    document.save(filepath)
                } else {
                    document.exportSvg(filepath)
                    exportSvg = false
                }
            }
        }
    }

    AboutDialog {
        id: aboutDialog
    }
}
