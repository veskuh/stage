// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include <QObject>
#include <QImage>
#include <QAbstractListModel>
#ifndef DECLARATIVESLIDEMODEL_H
#define DECLARATIVESLIDEMODEL_H
#include "slidedata.h"


class DeclarativeSlideModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum SlideRoles {
        NameRole = Qt::UserRole + 1,
        ImageIdRole
    };

    DeclarativeSlideModel(QObject *parent = nullptr);

    Q_INVOKABLE void addSlide(const QString &name, const QImage &image);
    Q_INVOKABLE void append(const SlideData slide);
    Q_INVOKABLE void insertSlide(int index, const QString &name, const QImage &image);
    Q_INVOKABLE void removeSlide(int index);
    Q_INVOKABLE void moveSlide(int from, int to);

    SlideData getSlide(int index);
    void setSlide(int index, SlideData data);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    QImage getImageById(const QString &id) const;
private:
    QList<SlideData> m_slides;
};

#endif
