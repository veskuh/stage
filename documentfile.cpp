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

#include "documentfile.h"
#include <QDebug>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonValue>
#include <QFile>

DocumentFile::DocumentFile()
{
}

void DocumentFile::addObject(QVariantMap &properties)
{
    jsonArray.append(QJsonObject::fromVariantMap(properties));
}

void DocumentFile::save(QUrl url)
{
    qDebug() << jsonArray;

    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("failed to create file for writing");
        return;
    }
    QJsonDocument document(jsonArray);
    file.write(document.toJson());

}

QList<QVariantMap> DocumentFile::load(QUrl url)
{
    QList<QVariantMap> list;

    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("failed to create file for reading");
        return list;
    }
    QJsonDocument document = QJsonDocument::fromJson(file.readAll());

    foreach (QJsonValue value, document.array()) {
        if (value.isObject())
            list.append(value.toObject().toVariantMap());
    }
    return list;
}

