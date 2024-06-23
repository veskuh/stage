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
//import Qt.labs.platform
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform as Labs
import com.mac.vesku.stage

ApplicationWindow {
    id: mainWindow

    property string state: "Ready"
    property Component factory
    property string inspectorSource
    property alias selection: selection
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


    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem {
                text: "Open...";
            //    shortcut: "Ctrl+O";
                onTriggered: {
                    content.clear()
                    openDialog.fileMode = FileDialog.OpenFile
                    openDialog.open()
                }
            }
            MenuSeparator {}
            MenuItem { text: "Close";
            //    shortcut: "Ctrl+W"
            }
            MenuItem {
                text: "Save"
            //    shortcut: "Ctrl+S"
                onTriggered: {
                    if (filepath == "") {
                        openDialog.fileMode = FileDialog.SaveFile
                        openDialog.open()
                    } else {
                        document.save(filepath)
                    }
                }
            }
            MenuItem {
                text: "Save As.."
                onTriggered: {
                    openDialog.selectExisting = false
                    openDialog.open()
                }
            }
            MenuItem { text: "Export.." }
            MenuSeparator {}
            MenuItem {
                text: "Print..";
            //    shortcut: "Ctrl+P"
            }

        }
        /*
        Menu {
            title: "Edit"
            MenuItem { text: "Undo"; shortcut: "Ctrl+Z" }
            MenuSeparator {}
            MenuItem { text: "Cut" ; shortcut: "Ctrl+X"}
            MenuItem { text: "Copy"; shortcut: "Ctrl+C" }
            MenuItem { text: "Paste"; shortcut: "Ctrl+V" }
            MenuSeparator {}
            MenuItem { text: "Select All"; shortcut: "Ctrl+A" }

        }*/
    }

    header: ToolBar {
        RowLayout {
            ToolButton {
                text: "Rectangle"
                checkable: true
                onClicked: {
                    factory = Qt.createComponent("StageRect.qml")
                    mainWindow.state = "Rectangle"
                }
            }
            ToolButton {
                text: "Circle"
                checkable: true
                onClicked: {
                    factory = Qt.createComponent("StageCircle.qml")
                    mainWindow.state = "Circle"
                }
            }
            ToolButton {
                text: "Text"
                checkable: true

                onClicked: {
                    factory = Qt.createComponent("StageText.qml")
                    mainWindow.state = "Text"
                }
            }
            ToolButton {
                text: "Image"
                checkable: true

                onClicked: {
                    factory = Qt.createComponent("StageImage.qml")
                    mainWindow.state = "Image"
                }
            }
            ToolButton {
                id: selectButton
                text: "Select"
                checkable: true
                checked: !factory

                onClicked: {
                    factory = null
                    mainWindow.state = "Select"
                }
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

        Rectangle {
            id: content
            objectName: "contentRectangle"
            height: 768
            SplitView.fillWidth: true

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
                    } else {
                        target = null
                    }
                }
            }

            SelectionHighlight {
                id: selection
                visible: target

                x: mainWindow.target? mainWindow.target.x : 0
                y: mainWindow.target? mainWindow.target.y : 0
                width: mainWindow.target? mainWindow.target.width : 0
                height: mainWindow.target? mainWindow.target.height : 0

            }
        }

        StackLayout {
            SplitView.preferredWidth: 300
            Item {
                id: inspector
                Rectangle {
                    width: 300
                    height: parent.height
                    color: palette.window

                    Loader {
                        source: mainWindow.inspectorSource
                    }
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
        nameFilters: [ "json files (*.json)"]

        onAccepted: {
            filepath = openDialog.currentFile
            if (fileMode==FileDialog.OpenFile) {
                document.load(filepath)

            } else {
                document.save(filepath)
            }
        }
    }
}