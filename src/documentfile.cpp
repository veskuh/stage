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
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QPainter>
#include <QImage>
#include "slidedata.h"
#include "objectrenderer.h"

DocumentFile::DocumentFile() {}

void DocumentFile::addObject(const QVariantMap &properties)
{
    jsonArray.append(QJsonObject::fromVariantMap(properties));
}

void DocumentFile::save(QUrl url)
{
    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("failed to create file for writing");
        return;
    }
    QJsonDocument document(jsonArray);
    file.write(document.toJson());

    //tbd Check if I need to clear the JsonArray
}

SlideData DocumentFile::load(QUrl url)
{
    SlideData slide;

    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("failed to create file for reading");
        return slide;
    }
    QJsonDocument document = QJsonDocument::fromJson(file.readAll());


    // Create a QImage that is the same size as the window
    QImage image(1920, 1080, QImage::Format_RGB32);

    // Create a QPainter object and pass it the QImage
    QPainter painter(&image);
    ObjectRenderer renderer;
    renderer.setPainter(&painter);
    renderer.clear();

    for (QJsonValue value : document.array()) {
        if (value.isObject()) {
            QVariantMap object = value.toObject().toVariantMap();
            renderer.renderObject(object);
            slide.append(object);
        }
    }
    // TODO render content to image and return it
    slide.setImage(image);
    return slide;
}
