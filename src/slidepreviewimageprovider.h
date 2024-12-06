// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include <QQuickImageProvider>
#include "declarativeslidemodel.h"
#ifndef SLIDEPREVIEWIMAGEPROVIDER_H
#define SLIDEPREVIEWIMAGEPROVIDER_H

class SlidePreviewImageProvider : public QQuickImageProvider {
public:
    SlidePreviewImageProvider();

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
    static void setSlideModel(DeclarativeSlideModel *model);

private:
    static DeclarativeSlideModel *m_slideModel;
};

#endif
