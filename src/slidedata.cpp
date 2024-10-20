#include "slidedata.h"
#include <QUuid>

void SlideData::setName(QString name) {
    m_name = name;
}

QString SlideData::name() const {
    return m_name;
}

void SlideData::setImage(QImage image) {
    m_image = image;
    m_imageId = QUuid::createUuid().toString(QUuid::WithoutBraces);
}

QImage SlideData::image() const {
    return m_image;
}

QString SlideData::imageId() const {
    return m_imageId;
}

QList<QVariantMap> SlideData::list() const {
    return *m_list;
}

void SlideData::append(QVariantMap properties){
    m_list->append(properties);
}

SlideData::~SlideData() noexcept
{
    try {
        // Cleanup code that might throw
    } catch (...) {
        // Handle the exception and ensure it doesn't propagate
    }
}

SlideData::SlideData() {
    m_list = new QList<QVariantMap>;
}
