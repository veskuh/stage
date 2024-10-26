#include "objectrenderer.h"
#include <QDebug>
#include <QUrl>

ObjectRenderer::ObjectRenderer()
    : m_painter(nullptr)
{
}

void ObjectRenderer::renderObject(QVariantMap& properties)
{
    if (m_painter == nullptr) {
        qCritical() << "Painter not set before rendering an object";
        return;
    }

    QString type = properties.value("type").toString();
    QRectF bounds = getRect(properties);
    QString colorStr = properties.value("color").toString();

    if (type == "StageRect") {
        int z = properties.value("z").toInt();
        m_painter->fillRect(bounds, QColor(colorStr));
    } else if (type == "StageCircle") {
        int z = properties.value("z").toInt();
        m_painter->setBrush(QColor(colorStr));
        m_painter->drawEllipse(bounds);
    } else if (type == "StageText") {
        int z = properties.value("z").toInt();
        QString text = properties.value("text").toString();
        int fontSize = properties.value("fontSize").toInt();
        QFont font = m_painter->font();
        font.setBold(properties.value("bold").toBool());
        font.setItalic(properties.value("italic").toBool());
        font.setUnderline(properties.value("underline").toBool());
        font.setPixelSize(fontSize);
        m_painter->setFont(font);
        QPen pen = m_painter->pen();
        pen.setColor(QColor(colorStr));
        m_painter->setPen(pen);
        m_painter->drawText(bounds, text);
    } else if (type == "StageImage") {
        QString path = properties.value("url").toUrl().toLocalFile();
        QImage img(path);

        if (img.isNull()) {
            qWarning() << "Can't load: " << path;
        } else {
            m_painter->drawImage(bounds, img);
        }
    } else if (type== "StageLine") {
        QPen pen = m_painter->pen();
        pen.setColor(QColor(colorStr));
        m_painter->setPen(pen);
        m_painter->drawLine(QPointF(bounds.x(), bounds.y()),QPointF(bounds.x()+bounds.width(), bounds.y()+bounds.height()));
    } else {
        qWarning() << "Export of type not implemented: " << type;
    }
}

void ObjectRenderer::setPainter(QPainter* painter)
{
    if (m_painter != nullptr) {
        qCritical() << "Painter already set";
        return;
    }

    m_painter = painter;
}

QRectF ObjectRenderer::getRect(QVariantMap properties) {
    qreal x = properties.value("x").toReal();
    qreal y = properties.value("y").toReal();
    qreal width = properties.value("width").toReal();
    qreal height = properties.value("height").toReal();
    return QRectF(x, y, width, height);
}
