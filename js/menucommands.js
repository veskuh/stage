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




