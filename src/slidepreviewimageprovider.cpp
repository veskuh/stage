#include "slidepreviewimageprovider.h"
#include <QDebug>

SlidePreviewImageProvider::SlidePreviewImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
    {}

QImage SlidePreviewImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize) {
    QImage image = m_slideModel->getImageById(id);
    if (!image.isNull()) {
        *size = image.size();
        if (requestedSize.isValid()) {
            image = image.scaled(requestedSize);
        }
        return image;
    }
    return QImage();  // Return an empty image if the ID is invalid
}

DeclarativeSlideModel* SlidePreviewImageProvider::m_slideModel = nullptr;

void SlidePreviewImageProvider::setSlideModel(DeclarativeSlideModel *model)
{
    if (model != m_slideModel) {
        m_slideModel = model;
    }
}
