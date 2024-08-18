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

#include "declarativedocument.h"
#include "documentfile.h"
#include "svgexport.h"
#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVariantMap>

DeclarativeDocument::DeclarativeDocument(QObject *parent)
    : QObject(parent)
{
    QFile file(":/assets/types.json");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("failed to create file for reading");
        return;
    }

    QJsonDocument document = QJsonDocument::fromJson(file.readAll());
    types = document.array();
}

void DeclarativeDocument::save(QUrl url)
{
    DocumentFile file;

    // Find ApplicationWindow
    QObject *obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject *>("contentRectangle");
    if (content) {
        for (QObject *object : content->children()) {
            QString className = object->metaObject()->className();
            for (QJsonValue type : types) {
                if (type.isObject()) {
                    QJsonObject typeObject = type.toObject();
                    QJsonValue value = typeObject.value("type");
                    if (value.isString()) {
                        QString typeString = value.toString();
                        if (className.startsWith(typeString)) {
                            QVariantMap properties;
                            properties.insert("type", QVariant(typeString));
                            QJsonValue propertyArray = typeObject.value("properties");
                            if (propertyArray.isArray()) {
                                for (auto property : propertyArray.toArray()) {
                                    if (property.isString()) {
                                        QString propertyString = property.toString();
                                        properties.insert(
                                            propertyString,
                                            object->property(propertyString.toLatin1().constData()));
                                    }
                                }
                            }
                            file.addObject(properties);
                        }
                    }
                }
            }
        }
    }
    file.save(url);
}

void DeclarativeDocument::exportSvg(QUrl url)
{
    SvgExport file(url.toLocalFile());

    // Find ApplicationWindow
    QObject *obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject *>("contentRectangle");
    if (content) {
        for (QObject *object : content->children()) {
            QString className = object->metaObject()->className();
            for (QJsonValue type : types) {
                if (type.isObject()) {
                    QJsonObject typeObject = type.toObject();
                    QJsonValue value = typeObject.value("type");
                    if (value.isString()) {
                        QString typeString = value.toString();
                        if (className.startsWith(typeString)) {
                            QVariantMap properties;
                            properties.insert("type", QVariant(typeString));
                            QJsonValue propertyArray = typeObject.value("properties");
                            if (propertyArray.isArray()) {
                                for (auto property : propertyArray.toArray()) {
                                    if (property.isString()) {
                                        QString propertyString = property.toString();
                                        properties.insert(
                                            propertyString,
                                            object->property(propertyString.toLatin1().constData()));
                                    }
                                }
                            }
                            file.addObject(properties);
                        }
                    }
                }
            }
        }
    }
    file.save();
}


void DeclarativeDocument::load(QUrl url)
{
    // Find ApplicationWindow
    QObject *obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject *>("contentRectangle");
    if (content) {
        QList<QVariantMap> list = DocumentFile::load(url);
        while (!list.isEmpty()) {
            QMetaObject::invokeMethod(
                content, "addObject", Q_ARG(QVariant, QVariant::fromValue(list.takeFirst())));
        }
    }
}
