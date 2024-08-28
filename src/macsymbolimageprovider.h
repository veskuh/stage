#ifndef MACSYMBOLIMAGEPROVIDER_H
#define MACSYMBOLIMAGEPROVIDER_H
#include <QQuickImageProvider>
#include <QString>
#include <QImage>


class MacSymbolImageProvider: public QQuickImageProvider
{
public:
    MacSymbolImageProvider();

    QImage requestImage(const QString &name,
                        QSize *size,
                        const QSize &requestedSize) override;

};

#endif // MACSYMBOLIMAGEPROVIDER_H

