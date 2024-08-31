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
    } else if (type == "StageText") {
        int z = properties.value("z").toInt();
        QString text = properties.value("text").toString();
        int fontSize = properties.value("fontSize").toInt();
        QFont font = painter.font();
        font.setBold(properties.value("bold").toBool());
        font.setItalic(properties.value("italic").toBool());
        font.setUnderline(properties.value("underline").toBool());
        font.setPixelSize(fontSize);
        painter.setFont(font);
        QPen pen = painter.pen();
        pen.setColor(QColor(colorStr));
        painter.setPen(pen);
        painter.drawText(bounds, text);
    } else if (type == "StageImage") {
        QString path = properties.value("url").toUrl().toLocalFile();
        QImage img(path);

        if (img.isNull()) {
            qWarning() << "Can't load: " << path;
        } else {
            painter.drawImage(bounds, img);
        }
    } else if (type== "StageLine") {
        QPen pen = painter.pen();
        pen.setColor(QColor(colorStr));
        painter.setPen(pen);
        painter.drawLine(QPointF(bounds.x(), bounds.y()),QPointF(bounds.x()+bounds.width(), bounds.y()+bounds.height()));
    } else {
        qWarning() << "Export of type not implemented: " << type;
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
