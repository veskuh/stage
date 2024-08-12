import QtQuick
import QtQml

StageBase {
    inspectorSource: "GroupInspector.qml"
    id: root

    property list<StageBase> members
    property bool activeSelection: mainWindow.target === root

    function add(target) {
        members.push(target)
        target.group = root
    }

    function clear() {
        for(var member in members){
            if (members[member]!=null) {
                if (members[member].group === root) {
                    members[member].group = null
                }
            }
        }
        member = []
    }

    function duplicate() {
        for(var member in members){
            if (members[member]!=null) {
               members[member].duplicate()
            }
        }
    }

    Component.onDestruction: {
        for(var member in members){
            if (members[member]!=null) {
                members[member].destroy()
                members[member] = null
            }
        }
    }
}
