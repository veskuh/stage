// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>



function open() {
    content.clear()
    content.fitToWindow = true
    openDialog.fileMode = FileDialog.OpenFile
    openDialog.open()
}

function close() {
    content.clear()
    content.fitToWindow = true
    mainWindow.filepath = ""
    document.newDocument()
}

function save() {
    if (mainWindow.filepath == "") {
        openDialog.fileMode = FileDialog.SaveFile
        openDialog.open()
    } else {
        document.save(mainWindow.filepath)
    }
}

function saveAs() {
    openDialog.fileMode = FileDialog.SaveFile
    openDialog.open()
}

function cut() {
    mainWindow.editItem.cut()
}

function copy() {
    mainWindow.editItem.copy()
}

function paste() {
    if (mainWindow.editItem && mainWindow.editItem.canPaste) {
        mainWindow.editItem.paste()
    } else {
        content.paste()
    }
}

function addSlide() {
    document.addSlide()
}


function exportSvg() {
    openDialog.fileMode = FileDialog.SaveFile
    openDialog.exportSvg = true
    openDialog.open()
}


function deleteTarget() {
    var element  = mainWindow.target
    mainWindow.target = null
    element.destroy()
}

function selectAll() {
    content.selectAll()
}

function deselect() {
    content.deselect()
}

function forward() {
    mainWindow.target.z += 1
}

function backward() {
    mainWindow.target.z -= 1
}

function duplicateTarget() {
    var element  = mainWindow.target
    target.duplicate()
}

function scaleToFit() {
    content.fitToWindow = true
}

function zoomIn() {
    content.userScale = content.scale * 2
    content.fitToWindow = false
}

function zoomOut() {
    content.userScale = content.scale / 2
    content.fitToWindow = false
}

function actualSize() {
    content.userScale = 1.0
    content.fitToWindow = false
}

function setLocked(locked) {
    mainWindow.target.enabled = !locked
}

function setVisible(visible) {
    mainWindow.target.visible = visible
}

function togglePresent() {
    mainWindow.presentInWindow = !mainWindow.presentInWindow
}




