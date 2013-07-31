import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

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

    width: 1024
    height: 768
    title: "Stage"

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
            MenuItem { text: "Open..."; shortcut: "Ctrl+O" }
            MenuSeparator {}
            MenuItem { text: "Close"; shortcut: "Ctrl+W" }
            MenuItem { text: "Save"; shortcut: "Ctrl+S" }
            MenuItem { text: "Save As.." }
            MenuItem { text: "Export.." }
            MenuSeparator {}
            MenuItem { text: "Print.."; shortcut: "Ctrl+P" }

        }
        Menu {
            title: "Edit"
            MenuItem { text: "Undo"; shortcut: "Ctrl+Z" }
            MenuSeparator {}
            MenuItem { text: "Cut" ; shortcut: "Ctrl+X"}
            MenuItem { text: "Copy"; shortcut: "Ctrl+C" }
            MenuItem { text: "Paste"; shortcut: "Ctrl+V" }
            MenuSeparator {}
            MenuItem { text: "Select All"; shortcut: "Ctrl+A" }

        }
    }

    toolBar: ToolBar {
        RowLayout {
            ToolButton {
                text: "Rectangle"
                checkable: true
                exclusiveGroup: activeTool
                onClicked: {
                    factory = Qt.createComponent("StageRect.qml")
                    mainWindow.state = "Rectangle"
                }
            }
            ToolButton {
                text: "Circle"
                checkable: true
                exclusiveGroup: activeTool
            }
            ToolButton {
                text: "Text"
                checkable: true
                exclusiveGroup: activeTool

                onClicked: {
                    factory = Qt.createComponent("StageText.qml")
                    mainWindow.state = "Text"
                }
            }
            ToolButton {
                text: "Image"
                checkable: true
                exclusiveGroup: activeTool

                onClicked: {
                    factory = Qt.createComponent("StageImage.qml")
                    mainWindow.state = "Image"
                }
            }
            ToolButton {
                text: "Select"
                checkable: true
                checked: true
                exclusiveGroup: activeTool

                onClicked: {
                    factory = null
                    mainWindow.state = "Select"
                }
            }
        }
    }

    statusBar: StatusBar {
        RowLayout {
            Label { text: mainWindow.state }
        }
    }

    SystemPalette {id: palette}
    ExclusiveGroup {id: activeTool}

    SplitView {
        anchors.fill: parent
        resizing: true


        Rectangle {
            id: content
            height: 768
            Layout.fillWidth: true

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
                    } else {
                        target = null
                    }
                }
            }
            StageRect {
                x: 200
                y: 200
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

        Component {
            id: inspector
            Rectangle {
                width: 200
                height: parent.height
                color: palette.window

                Loader {
                    source: mainWindow.inspectorSource
                }
            }
        }

        Component {
            id: styles

            Rectangle {
                width:200
                height:200

                color: palette.window

            }
        }

        Component {
            id: slides

            Rectangle {
                width:200
                height:200

                color: palette.window

            }
        }


        TabView {
            width: 300

            Tab {
                title: "Inspector"
                source: mainWindow.inspectorSource
            }

            Tab {
                title: "Styles"
                source: "StylesTab.qml"
            }

            Tab {
                title: "Slides"
                source: "SlidesTab.qml"
            }
        }

    }


    onTargetChanged: {
        if (!target) {
            inspectorSource = ""
        }
    }
}
