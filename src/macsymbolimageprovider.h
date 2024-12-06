// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#ifndef MACSYMBOLIMAGEPROVIDER_H
#define MACSYMBOLIMAGEPROVIDER_H
#include <QQuickImageProvider>
#include <QString>
#include <QImage>

/**
 * @brief The MacSymbolImageProvider class provides icons for tools when run on Mac
 */
class MacSymbolImageProvider: public QQuickImageProvider
{
public:
    MacSymbolImageProvider();

    QImage requestImage(const QString &name,
                        QSize *size,
                        const QSize &requestedSize) override;

};

#endif // MACSYMBOLIMAGEPROVIDER_H

