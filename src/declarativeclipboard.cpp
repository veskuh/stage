// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include <QMimeData>
#include <QImage>
#include <QBuffer>
#include <QDebug>
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

QString DeclarativeClipboard::imageData()
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    QImage image = clipboard->image();
    QBuffer buffer;
    buffer.open(QIODevice::WriteOnly);
    image.save(&buffer, "PNG");
    QString retval("data:image/png;base64,");
    retval.append(buffer.data().toBase64());
    return retval;
}

bool DeclarativeClipboard::hasImage() {
    QClipboard *clipboard = QGuiApplication::clipboard();
    return clipboard->mimeData()->hasImage();
}

void DeclarativeClipboard::updateStatus() {
    emit clipboardTextChanged();
}

