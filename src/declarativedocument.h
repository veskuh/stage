// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>
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
    Q_PROPERTY(int currentSlideIndex READ currentSlideIndex NOTIFY currentSlideIndexChanged)
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
     * @brief addSlide new slide
     * @param index for the new slide, default to the end
     */
    Q_INVOKABLE void addSlide(int index=-1);

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
    Q_INVOKABLE void nextSlide();
    Q_INVOKABLE void previousSlide();
    Q_INVOKABLE int currentSlideIndex();


signals:
    void slideModelChanged();
    void currentSlideIndexChanged();

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
