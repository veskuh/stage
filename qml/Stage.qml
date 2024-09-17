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
import "./objects"
import "./inspectors"
import "../js/menucommands.js" as MenuCommands
import "../js/utils.js" as Utils

ApplicationWindow {
    id: mainWindow

    property string state: "Select"
    property Component factory
    property string inspectorSource
    property Item target
    property bool select: !factory
    property alias view: content
    property Item draggedObject
    property Item verticalAnchor
    property Item horizontalAnchor
    property url filepath
    property Item editItem

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

    Clipboard {
        id: clipboard
    }

    menuBar: Qt.platform.os == "osx" ? null : qmlMenu
    MacMenu {}
    QmlMenu {
        id: qmlMenu
        visible: Qt.platform.os !== "osx"
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
                factory = Qt.createComponent("./objects/"+factoryQmlName)
                mainWindow.state = state
            }

        }
    }

    footer: ToolBar {
        RowLayout {
            Label { text: mainWindow.state }
        }

        RowLayout {
            anchors.right: parent.right
            Label { text: content.scale * 100 + "% " }
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
                    var component = Qt.createComponent("./objects/" + properties.type + ".qml")
                    if (component.status === Component.Ready) {
                        component.createObject(content, properties)
                    } else {
                        console.log("Cannot create component for type: " + properties.type)
                    }
                }

                function clear() {
                    for (var child in content.children) {
                        if (content.children[child].objectName === "StageBase") {
                            content.children[child].destroy(10)
                        }
                    }
                }

                function selectAll() {
                    select(null,true)
                }

                function select(selectionArea, all=false) {
                    content.deselect()
                    var group = content.getGroup()
                    for (var child in content.children) {
                        var childObject = content.children[child]
                        if (childObject.type && childObject.type!=="Group" && childObject.objectName === "StageBase") {
                            if (all) {
                                group.add(content.children[child])
                            } else {
                                var obj = content.children[child]
                                var area = selectionArea
                                if (obj.x >= area.x && obj.x <= area.x + area.width
                                        && obj.y >= area.y && obj.y <= area.y + area.height
                                        && obj.x + obj.width < area.x + area.width
                                        && obj.y + obj.height < area.y + area.height
                                        )
                                {
                                    group.add(content.children[child])
                                }
                            }
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
                        var component = Qt.createComponent("objects/Group.qml")
                        if (component.status === Component.Ready) {
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

                function paste() {
                    var text = clipboard.clipboardText
                    addObject({"type":"StageText","x":50,"y":50,"text":text})

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
                        } else if (selectionArea.visible) {
                            selectionArea.visible = false
                        } else {
                            content.deselect()
                        }
                    }
                    onPressed: (mouse) => {
                                   if (mainWindow.state == "Select" && !selectionArea.visible) {
                                       selectionArea.x = mouse.x
                                       selectionArea.y = mouse.y
                                       selectionArea.visible = true
                                       preventStealing = true
                                   }
                               }
                    onReleased: (mouse) => {
                                    if (mainWindow.state == "Select" && selectionArea.visible) {
                                        content.select(selectionArea)
                                        selectionArea.width = 2
                                        selectionArea.height = 2
                                    }
                                }

                    onPositionChanged: (mouse) => {
                                           if (selectionArea.visible) {
                                               selectionArea.width = mouse.x - selectionArea.x
                                               selectionArea.height = mouse.y - selectionArea.y
                                           }
                                       }
                }

                Rectangle {
                    id: selectionArea
                    color: "grey"
                    opacity: 0.3
                    visible: false
                    width: 2
                    height: 2
                    z:999
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
                    id: loader
                    anchors.fill: parent
                    property string sourceUrl: mainWindow.inspectorSource? "./inspectors/" + mainWindow.inspectorSource : ""
                    property Item currentTarget: mainWindow.target

                    onStatusChanged: {
                        if (loader.status == Loader.Error ) {
                            console.log("Error in loading" + source)
                        }
                    }

                    onSourceUrlChanged: {
                        setSource(sourceUrl, { "target": currentTarget })
                    }

                    onCurrentTargetChanged: {
                        setSource(sourceUrl, { "target": currentTarget })
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

    property FileDialog openDialog: FileDialog {
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

    property AboutDialog aboutDialog: AboutDialog {}

    onActiveFocusItemChanged: {
        // Mac menu doesn't mess with activefocus similarly as linux
        if (Qt.platform.os == "osx") {
            editItem = activeFocusItem
        } else {
            var thisItem = activeFocusItem
            while (thisItem) {
                if (thisItem.objectName === "Stage") {
                    // Items that are children of window are proper items
                    editItem = activeFocusItem
                    break
                }
                thisItem = thisItem.parent
            }
        }
    }
}
