#ifndef SVGEXPORT_H
#define SVGEXPORT_H

#include <QString>
#include <QSvgGenerator>
#include <QPainter>

class SvgExport
{
public:
    SvgExport(QString path);
    void addObject(QVariantMap properties);
    void save();

private:
    /**
     * @brief getRect get x,y,width, height from propertyMap
     * @param properties
     * @return
     */
    QRectF getRect(QVariantMap properties);

    QSvgGenerator generator;
    QPainter painter;
};

#endif // SVGEXPORT_H
