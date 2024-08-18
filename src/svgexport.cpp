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

    if (type == "StageRect") {
        int x,y,z, width, height = 0;

        x = properties.value("x").toInt();
        y = properties.value("y").toInt();
        z = properties.value("z").toInt();
        width = properties.value("width").toInt();
        height = properties.value("height").toInt();

        QString colorStr = properties.value("color").toString();

        painter.fillRect(x, y, width, height, QColor(colorStr));
    }
}

void SvgExport::save() {

    painter.end();
}
