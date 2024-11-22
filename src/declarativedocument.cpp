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
    SlideData slide;
    slide.setList(new StageObjectList());
    m_slideModel->append(slide);
    SlidePreviewImageProvider::setSlideModel(m_slideModel);

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
    SlideData slide = m_slideModel->getSlide(index);
    if (updateCurrent) {
        updateSlideContent(currentSlide);
        emit slideModelChanged();
    }
    showSlide(slide);
    currentSlide = index;
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
