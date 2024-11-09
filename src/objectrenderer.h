#ifndef OBJECTRENDERER_H
#define OBJECTRENDERER_H

#include <QPainter>
#include <QVariantMap>


/**
 * @brief The ObjectRenderer class renders user objects using QPainter
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
