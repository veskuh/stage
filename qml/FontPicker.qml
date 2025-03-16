import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

FontDialog {
    id: fontDialog
    options: FontDialog.NoButtons

    property bool editing: false
    property Item target

    onSelectedFontChanged: {
        if (editing) {
            target.underline = selectedFont.underline
            target.bold = selectedFont.bold
            target.italic = selectedFont.italic
            target.fontName = selectedFont.family
            target.fontSize = selectedFont.pixelSize
        }
    }

    onVisibleChanged: {
        if (visible) {
            update()
        }
    }

    onTargetChanged: {
        if (visible) {
            visible = false
            visible = true
        }
    }

    function update() {
        if (target && target.type == "StageText") {
            editing = false

            selectedFont.family = target.fontName
            selectedFont.italic = target.italic
            selectedFont.bold = target.bold
            selectedFont.underline = target.underline
            selectedFont.pixelSize = target.fontSize
            editing = true
        }
    }
}
