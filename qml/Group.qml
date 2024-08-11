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

    Component.onDestruction: {
        for(var member in members){
            members[member].destroy()
            members[member] = null
        }
    }
}
