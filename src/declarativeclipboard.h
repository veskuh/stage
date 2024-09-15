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

signals:
    void clipboardTextChanged();

private:
    void updateStatus();

};

#endif // DECLARATIVECLIPBOARD_H
