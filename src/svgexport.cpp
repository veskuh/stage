// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "svgexport.h"

#include <QSize>
#include <QRect>
#include <QVariantMap>
#include <QDebug>
#include <QUrl>

SvgExport::SvgExport(QString path) {
    qDebug() << "exporting to:" << path;
    generator.setFileName(path);
    generator.setSize(QSize(1920, 1080));
    generator.setViewBox(QRect(0, 0, 1920, 1080));
    generator.setTitle("Stage export image");
    generator.setDescription("Export by Qt SVG Generator");
    renderer.setPainter(&painter);

    painter.begin(&generator);
    renderer.clear();
}

void SvgExport::addObject(QVariantMap properties) {
    renderer.renderObject(properties);
}

void SvgExport::save() {

    painter.end();
}
