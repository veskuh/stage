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
#include "slidepreviewimageprovider.h"

DocumentFile::DocumentFile() {}

void DocumentFile::save(QUrl url, DeclarativeSlideModel* slideModel)
{
    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("failed to create file for writing");
        return;
    }

    QJsonArray slides;

    int slideCount = slideModel->rowCount();
    for (int i = 0; i < slideCount; i++ ) {
        SlideData slide = slideModel->getSlide(i);
        QJsonArray slideJson;
        QList<QVariantMap> objectList  = slide.list();
        for (QVariantMap slideObject : objectList) {
            slideJson.append(QJsonObject::fromVariantMap(slideObject));
        }
        slides.append(slideJson);
    }

    QJsonDocument document(slides);
    file.write(document.toJson());
}

DeclarativeSlideModel* DocumentFile::load(QUrl url)
{
    DeclarativeSlideModel* model = new DeclarativeSlideModel();
    SlidePreviewImageProvider::setSlideModel(model);


    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("failed to create file for reading");
        return model;
    }
    QJsonDocument jsonDoc = QJsonDocument::fromJson(file.readAll());

    if (!jsonDoc.isArray()) {
        qWarning("Not a propertly formatted doc");
        return model;
    }
    QJsonArray slideArray = jsonDoc.array();

    for (QJsonValue slideObjects : slideArray) {

        SlideData slide;
        // For individual slide
        for (QJsonValue value : slideObjects.toArray()) {
            // Add all objects to canvas an
            if (value.isObject()) {
                QVariantMap object = value.toObject().toVariantMap();
                slide.append(object);
            }
        }
        slide.createImage();
        model->append(slide);
    }
    return model;
}
