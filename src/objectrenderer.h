#ifndef OBJECTRENDERER_H
#define OBJECTRENDERER_H

#include <QPainter>
#include <QVariantMap>

class ObjectRenderer
{
public:
    ObjectRenderer();
    void renderObject(QVariantMap& properties);
    void setPainter(QPainter* painter);

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
