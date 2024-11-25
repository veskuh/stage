#ifndef SVGEXPORT_H
#define SVGEXPORT_H

#include <QString>
#include <QSvgGenerator>
#include <QPainter>
#include "objectrenderer.h"

class SvgExport
{
public:
    SvgExport(QString path);
    void addObject(QVariantMap properties);
    void save();

private:

    QSvgGenerator generator;
    QPainter painter;
    ObjectRenderer renderer;
};

#endif // SVGEXPORT_H
