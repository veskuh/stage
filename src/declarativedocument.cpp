// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "declarativedocument.h"
#include "documentfile.h"
#include "svgexport.h"
#include "slidedata.h"
#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QVariantMap>
#include "slidepreviewimageprovider.h"



DeclarativeDocument::DeclarativeDocument(QObject *parent)
    : QObject(parent)
{
    // We load supported objects & properties from json in the beginning
    QFile file(":/assets/types.json");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("failed to create file for reading");
        return;
    }
    QJsonDocument document = QJsonDocument::fromJson(file.readAll());
    types = document.array();

    // And set up with a new document
    newDocument();
}


void DeclarativeDocument::newDocument() {
    if (m_slideModel) {
        delete m_slideModel;
    }
    m_slideModel = new DeclarativeSlideModel();

    // Add empty first slide
    addSlide();
    SlidePreviewImageProvider::setSlideModel(m_slideModel);

    emit slideModelChanged();
}

void::DeclarativeDocument::addSlide(int index) {
    SlideData slide;
    slide.setList(new StageObjectList());
    m_slideModel->append(slide);
    emit slideModelChanged();
}

void DeclarativeDocument::save(QUrl url)
{
    DocumentFile file;
    updateSlideContent(currentSlide);
    file.save(url, m_slideModel);
}

StageObjectList* DeclarativeDocument::contentObjects(QObject* content) {
    StageObjectList* list = new StageObjectList();

    if (content) {
        // We go through all child objects under content
        // check if they are of supported type - e.g StageRect
        // and then store its properties and the type name in QVariantMap
        // and append all the QVariantMaps of all supprted objects to QList to be returned
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
                            list->append(properties);
                        }
                    }
                }
            }
        }
    }
    return list;
}


void DeclarativeDocument::updateSlideContent(int index) {
    SlideData slide;
    QObject *content = contentObject("contentRectangle");
    slide.setList(contentObjects(content));
    m_slideModel->setSlide(index, slide);
}

void DeclarativeDocument::exportSvg(QUrl url)
{
    SvgExport file(url.toLocalFile());
    QObject *content = contentObject("m_painter->");
    StageObjectList* objectList = contentObjects(content);
    for (QVariantMap properties : *objectList) {
        file.addObject(properties);
    }
    delete objectList;
    file.save();
}

void DeclarativeDocument::showSlide(int index, bool updateCurrent) {
    if (index == currentSlide)
        return;
    SlideData slide = m_slideModel->getSlide(index);
    if (updateCurrent) {
        updateSlideContent(currentSlide);
        emit slideModelChanged();
    }
    showSlide(slide);
    currentSlide = index;
    emit currentSlideIndexChanged();
}

void DeclarativeDocument:: nextSlide() {
    if (currentSlide < (m_slideModel->rowCount()-1)) {
        showSlide(currentSlide+1);
    }
}

void DeclarativeDocument::previousSlide() {
    if (currentSlide > 0) {
        showSlide(currentSlide-1);
    }
}

int DeclarativeDocument::currentSlideIndex()
{
    return currentSlide;
}

void DeclarativeDocument::updateCurrentSlide()
{
    updateSlideContent(currentSlideIndex());
}


QObject* DeclarativeDocument::contentObject(QString type) {
    // Find ApplicationWindow
    QObject *obj = parent();
    while (obj->parent()) {
        obj = obj->parent();
    }

    QObject *content = obj->findChild<QObject *>(type);
    if (!content)
        return NULL;
    return content;
}

void DeclarativeDocument::showSlide(SlideData& slide) {
    QObject* content = contentObject("contentRectangle");
    QMetaObject::invokeMethod(
        content, "clear");

    StageObjectList list = slide.list();
    while (!list.isEmpty()) {
        QMetaObject::invokeMethod(
            content, "addObject", Q_ARG(QVariant, QVariant::fromValue(list.takeFirst())));
    }
}

void DeclarativeDocument::load(QUrl url) {
    setSlideModel(DocumentFile::load(url));
    currentSlide = -1; // Otherwise showSlide will skip showing first slide
    showSlide(0, false);
}

void DeclarativeDocument::setSlideModel(DeclarativeSlideModel* model) {
    DeclarativeSlideModel* tmp = m_slideModel;
    m_slideModel = model;
    SlidePreviewImageProvider::setSlideModel(m_slideModel);
    emit slideModelChanged();
    delete tmp; // For some reason setSlideModel gets called again if I delete the old one, TOOD figure out why, QML has ownership maybe?
}


DeclarativeSlideModel* DeclarativeDocument::slideModel() const {
    return m_slideModel;
}
