import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: mainWindow

    property string state: "Ready"
    property Component factory
    property alias inspectorSource: inspectorLoader.source
    property alias selection: selection
    property Item target
    property bool select: !factory

    width: 1024
    height: 768
    title: "Stage"

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
        Rectangle {
            width: 200
            height: parent.height
            color: palette.window

            Loader {
                id: inspectorLoader
            }
        }
    }


    onTargetChanged: {
        if (!target) {
            inspectorSource = ""
        }
    }
}
