#ifndef OBJECTRENDERER_H
#define OBJECTRENDERER_H

#include <QPainter>
#include <QVariantMap>


/**
 * @brief The ObjectRenderer class renders user objects using QPainter. Backend can be export like SVG or QImage like with slide preview.
 */
class ObjectRenderer
{
public:
    ObjectRenderer();
    void renderObject(QVariantMap& properties);
    void setPainter(QPainter* painter);
    void clear();

private:
    /**
     * @brief getRect get x,y,width, height from propertyMap
     * @param properties
     * @return
     */
    QRectF getRect(QVariantMap properties);

    QPainter* m_painter;

};

#endif // OBJECTRENDERER_H
