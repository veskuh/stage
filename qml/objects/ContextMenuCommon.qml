import QtQuick
import QtQuick.Controls

Menu {
    MenuItem {
        text: "Delete"
        onTriggered: base.activeObject().destroy()
    }
    MenuItem {
        text: "Duplicate"
        onTriggered: base.activeObject().duplicate()
    }
    MenuItem {
        text: "Hide"
        onTriggered: base.activeObject().visible = false
    }
    MenuItem {
        text: "Lock"
        onTriggered: base.activeObject().enabled = false
    }
    MenuItem {
        text: "Bring forward"
        onTriggered: base.activeObject().forward()
    }
    MenuItem {
        text: "Send backward"
        onTriggered: base.activeObject().backward()
    }
}
