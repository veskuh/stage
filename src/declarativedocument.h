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
#ifndef DECLARATIVEDOCUMENT_H
#define DECLARATIVEDOCUMENT_H

#include <QJsonArray>
#include <QObject>
#include <QUrl>

#include "declarativeslidemodel.h"

typedef QList<QVariantMap> StageObjectList;


class DeclarativeDocument : public QObject
{
    Q_OBJECT

    /* TODO
     * Load image
     * addSlide()
     * insertSlide()
     * deleteSlide(int slide)
     */
    // Q_PROPERTY(QString clipboardText READ clipboardText WRITE setClipboardText NOTIFY clipboardTextChanged)
    Q_PROPERTY(DeclarativeSlideModel* slideModel READ slideModel WRITE setSlideModel NOTIFY slideModelChanged)

public:
    explicit DeclarativeDocument(QObject *parent = 0);

    /**
     * @brief save Save current document to a file
     * @param url
     */
    Q_INVOKABLE void save(QUrl url);

    /**
     * @brief exportSvg Save current slide to svg documetn
     * @param url
     */
    Q_INVOKABLE void exportSvg(QUrl url);

    /**
     * @brief load a file as current document
     * @param url
     */
    Q_INVOKABLE void load(QUrl url);

    /**
     * @brief newDocument create a new document with one empty slide
     */
    Q_INVOKABLE void newDocument();

    /**
     * @brief slideModel of current docuemtn
     * @return
     */
    Q_INVOKABLE DeclarativeSlideModel* slideModel() const;

    /**
     * @brief setSlideModel for current documetn
     * @param model
     */
    Q_INVOKABLE void setSlideModel(DeclarativeSlideModel* model);

    /**
     * @brief showSlide from current documetn
     * @param index
     * @param updateCurrent save state (edits) of current slide before changeing
     */
    Q_INVOKABLE void showSlide(int index, bool updateCurrent = true);

signals:
    void slideModelChanged();

public slots:

private:
    QJsonArray types;
    DeclarativeSlideModel* m_slideModel;

    /**
     * @brief showSlide
     * @param slide
     */
    void showSlide(SlideData& slide);

    /**
     * @brief updateSlideContent save state (edits) of current slide and update preview
     * @param index
     */
    void updateSlideContent(int index);

    /**
     * @brief contentObject finds QML object that contains user content
     * @param type
     * @return
     */
    QObject* contentObject(QString type);

    /**
     * @brief contentObjects returns current slide's content from the view
     * @param content
     * @return
     */
    StageObjectList* contentObjects(QObject* content);

    int currentSlide = 0;
};

#endif // DECLARATIVEDOCUMENT_H
