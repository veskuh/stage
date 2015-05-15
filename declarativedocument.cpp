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
#include <QDebug>
#include <QVariantMap>
#include "documentfile.h"

DeclarativeDocument::DeclarativeDocument(QObject *parent) :
    QObject(parent)
{
}

void DeclarativeDocument::save(QUrl url)
{
    DocumentFile file;

    // Find ApplicationWindow
    QObject* obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject*>("contentRectangle");
    if (content) {
        Q_FOREACH (QObject *object, content->children())
        {
            QString className = object->metaObject()->className();
            if (className.startsWith("StageRect")) {
                QVariantMap properties;
                properties.insert("type", QVariant("rect"));
                properties.insert("x", object->property("x"));
                properties.insert("y", object->property("y"));
                properties.insert("width", object->property("width"));
                properties.insert("height", object->property("height"));
                file.addObject(properties);
            }
        }
    }
    file.save(url);
}

void DeclarativeDocument::load(QUrl url)
{
    // Find ApplicationWindow
    QObject* obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject*>("contentRectangle");
    if (content) {
        QList<QVariantMap> list = DocumentFile::load(url);
        while(!list.isEmpty())
            QMetaObject::invokeMethod(content, "addObject", Q_ARG(QVariant, QVariant::fromValue(list.takeFirst())));
    }
}

