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


class DeclarativeDocument : public QObject
{
    Q_OBJECT

    /* TODO
     * Load image
     *  - Populate model
     *
     * int currentSlide
     * ===
     * model sets new slide slide active
     * - render content to QImage and update the Model
     * - clear content
     * - draw data to content
     *
     * int slides
     *
     * Probably note needed
     *    getPreviews() //
     * updateSlide(int slide)
     * addSlide()
     * insertSlide()
     * deleteSlide(int slide)
     */
    // Q_PROPERTY(QString clipboardText READ clipboardText WRITE setClipboardText NOTIFY clipboardTextChanged)
    Q_PROPERTY(DeclarativeSlideModel* slideModel READ slideModel WRITE setSlideModel NOTIFY slideModelChanged)

public:
    explicit DeclarativeDocument(QObject *parent = 0);

    Q_INVOKABLE void save(QUrl url);
    Q_INVOKABLE void exportSvg(QUrl url);
    Q_INVOKABLE void load(QUrl url);

    Q_INVOKABLE DeclarativeSlideModel* slideModel() const;
    Q_INVOKABLE void setSlideModel(DeclarativeSlideModel* model);

signals:
    void slideModelChanged();

public slots:

private:
    QJsonArray types;
    DeclarativeSlideModel* m_slideModel;
};

#endif // DECLARATIVEDOCUMENT_H
