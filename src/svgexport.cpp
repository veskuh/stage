#include "svgexport.h"

#include <QSize>
#include <QRect>
#include <QVariantMap>
#include <QDebug>

SvgExport::SvgExport(QString path) {
    qDebug() << "exporting to:" << path;
    generator.setFileName(path);
    generator.setSize(QSize(1920, 1080));
    generator.setViewBox(QRect(0, 0, 1920, 1080));
    generator.setTitle("Stage export image");
    generator.setDescription("Export by Qt SVG Generator");

    painter.begin(&generator);
    painter.eraseRect(0,0,1920,1080);
}

void SvgExport::addObject(QVariantMap properties) {
    QString type = properties.value("type").toString();
    QRectF bounds = getRect(properties);
    QString colorStr = properties.value("color").toString();

    if (type == "StageRect") {
        int z = properties.value("z").toInt();
        painter.fillRect(bounds, QColor(colorStr));
    } else if (type == "StageCircle") {
        int z = properties.value("z").toInt();
        painter.setBrush(QColor(colorStr));
        painter.drawEllipse(bounds);
    }
}

QRectF SvgExport::getRect(QVariantMap properties) {
    qreal x = properties.value("x").toReal();
    qreal y = properties.value("y").toReal();
    qreal width = properties.value("width").toReal();
    qreal height = properties.value("height").toReal();
    return QRectF(x, y, width, height);
}


void SvgExport::save() {

    painter.end();
}
