// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

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
