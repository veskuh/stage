// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "slidedata.h"
#include <QUuid>
#include <QImage>
#include <QPainter>
#include "objectrenderer.h"

void SlideData::setName(QString name) {
    m_name = name;
}

QString SlideData::name() const {
    return m_name;
}

void SlideData::createImage() {
    QImage image(1920, 1080, QImage::Format_RGB32);
    QPainter painter(&image);
    ObjectRenderer renderer;
    renderer.setPainter(&painter);
    renderer.clear();
    for (QVariantMap object : *m_list) {
        renderer.renderObject(object);
    }
    setImage(image);
}


void SlideData::setImage(QImage image) {
    m_image = image;
    m_imageId = QUuid::createUuid().toString(QUuid::WithoutBraces);
}

QImage SlideData::image() const {
    return m_image;
}

QString SlideData::imageId() const {
    return m_imageId;
}

QList<QVariantMap> SlideData::list() const {
    return *m_list;
}

void SlideData::setList(QList<QVariantMap>* list) {
    delete m_list;
    m_list = list;
    createImage();
}

void SlideData::append(QVariantMap properties){
    m_list->append(properties);
}

SlideData::~SlideData() noexcept
{
    try {
        // Cleanup code that might throw
    } catch (...) {
        // Handle the exception and ensure it doesn't propagate
    }
}

SlideData::SlideData() {
    m_list = new QList<QVariantMap>;
}
