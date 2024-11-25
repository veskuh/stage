#include <QQuickImageProvider>
#include "declarativeslidemodel.h"
#ifndef SLIDEPREVIEWIMAGEPROVIDER_H
#define SLIDEPREVIEWIMAGEPROVIDER_H

class SlidePreviewImageProvider : public QQuickImageProvider {
public:
    SlidePreviewImageProvider();

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
    static void setSlideModel(DeclarativeSlideModel *model);

private:
    static DeclarativeSlideModel *m_slideModel;
};

#endif
