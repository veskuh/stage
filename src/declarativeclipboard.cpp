// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

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

