/*
Stage - a simple presentation application
Copyright (C) 2024 Vesa-Matti Hartikainen <vesku.h@gmail.com>

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

#include "declarativeclipboard.h"

DeclarativeClipboard::DeclarativeClipboard(QObject *parent)
    : QObject(parent) {
    QClipboard *clipboard = QGuiApplication::clipboard();
    connect(clipboard, &QClipboard::dataChanged, this, &DeclarativeClipboard::updateStatus);
}

QString DeclarativeClipboard::clipboardText() {
    QClipboard *clipboard = QGuiApplication::clipboard();
    return clipboard->text();
}

void DeclarativeClipboard::setClipboardText(const QString &text) {
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text);
}

void DeclarativeClipboard::updateStatus() {
    emit clipboardTextChanged();
}

