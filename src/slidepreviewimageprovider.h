#include <QQuickImageProvider>
#include "declarativeslidemodel.h"
#ifndef SLIDEPREVIEWIMAGEPROVIDER_H
#define SLIDEPREVIEWIMAGEPROVIDER_H

class SlidePreviewImageProvider : public QQuickImageProvider {
public:
    SlidePreviewImageProvider(DeclarativeSlideModel *model);

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

private:
    DeclarativeSlideModel *m_slideModel;
};

#endif
