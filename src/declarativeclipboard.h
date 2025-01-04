// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#ifndef DECLARATIVECLIPBOARD_H
#define DECLARATIVECLIPBOARD_H

#include <QObject>
#include <QClipboard>
#include <QGuiApplication>

class DeclarativeClipboard : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString clipboardText READ clipboardText WRITE setClipboardText NOTIFY clipboardTextChanged)
public:
    explicit DeclarativeClipboard(QObject *parent = nullptr);

    /**
     * @brief clipboardText return textual content of clipboard
     * @return
     */
    Q_INVOKABLE QString clipboardText();

    /**
     * @brief setClipboardText - copy text to clipboard
     * @param text
     */
    Q_INVOKABLE void setClipboardText(const QString &text);

    /**
     * @brief imageData returns base64 encoded string to be used in QML Image url
     * @return
     */
    Q_INVOKABLE QString imageData();

    /**
     * @brief hasImage true if clipboard has an image
     * @return
     */
    Q_INVOKABLE bool hasImage();


signals:
    void clipboardTextChanged();

private:
    void updateStatus();

};

#endif // DECLARATIVECLIPBOARD_H
