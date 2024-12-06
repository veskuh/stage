// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#ifndef DOCUMENTFILE_H
#define DOCUMENTFILE_H
#include <QJsonArray>
#include <QJsonObject>
#include <QString>
#include <QUrl>
#include <QVariantMap>
#include "declarativeslidemodel.h"

/**
 * @brief The DocumentFile class handles loading and saving the model that contains the slideset
 */
class DocumentFile
{
public:
    DocumentFile();

    void save(QUrl url, DeclarativeSlideModel* slideModel);
    static DeclarativeSlideModel* load(QUrl url);

};

#endif // DOCUMENTFILE_H
