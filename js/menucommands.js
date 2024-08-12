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
    openDialog.fileMode = FileDialog.OpenFile
    openDialog.open()
}

function save() {
    if (filepath == "") {
        openDialog.fileMode = FileDialog.SaveFile
        openDialog.open()
    } else {
        document.save(filepath)
    }
}

function saveAs() {
    openDialog.fileMode = FileDialog.SaveFile
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
