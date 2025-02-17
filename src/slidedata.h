// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#ifndef SLIDEDATA_H
#define SLIDEDATA_H

#include <QList>
#include <QMap>
#include <QVariantMap>
#include <QImage>

/**
 * @brief The SlideData class contains single slide's data (a list of objects) and preview image
 */
class SlideData
{
public:
    SlideData();
    ~SlideData() noexcept;

    void append(QVariantMap properties);

    void setName(QString name);
    QString name() const;

    void createImage();
    void setImage(QImage image);
    QImage image() const;

    QString imageId() const;

    void setList(QList<QVariantMap>* list);
    QList<QVariantMap> list() const;

private:
    // Slide is just a list of objects
    // object is just a set of Key/Value pairs
    QList<QVariantMap>* m_list;
    QString m_name;
    QImage m_image;
    QString m_imageId;
};

#endif // SLIDEDATA_H
