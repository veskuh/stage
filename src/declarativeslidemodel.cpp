#include "declarativeslidemodel.h"
#include <QUuid>


DeclarativeSlideModel::DeclarativeSlideModel(QObject *parent)
    : QAbstractListModel(parent) {}

void DeclarativeSlideModel::addSlide(const QString &name, const QImage &image) {
    SlideData slide;
    slide.setName(name);
    slide.setImage(image);

    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_slides.append(slide);
    endInsertRows();
}

void DeclarativeSlideModel::append(SlideData slide) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_slides.append(slide);
    endInsertRows();
}


void DeclarativeSlideModel::insertSlide(int index, const QString &name, const QImage &image) {
    if (index < 0 || index > rowCount()) {
        return;  // Invalid index, do nothing
    }
    SlideData slide;
    slide.setName(name);
    slide.setImage(image);

    beginInsertRows(QModelIndex(), index, index);
    m_slides.insert(index, slide);
    endInsertRows();
}

void DeclarativeSlideModel::removeSlide(int index) {
    if (index < 0 || index >= rowCount()) {
        return;  // Invalid index, do nothing
    }
    beginRemoveRows(QModelIndex(), index, index);
    m_slides.removeAt(index);
    endRemoveRows();
}

void DeclarativeSlideModel::moveSlide(int from, int to) {
    if (from < 0 || from >= rowCount() || to < 0 || to >= rowCount() || from == to) {
        return;  // Invalid indices or same position
    }

    beginMoveRows(QModelIndex(), from, from, QModelIndex(), (from < to ? to + 1 : to));
    m_slides.move(from, to);  // Use QList's move method
    endMoveRows();
}

int DeclarativeSlideModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_slides.count();
}


QVariant DeclarativeSlideModel::data(const QModelIndex &index, int role) const {
    if (index.row() < 0 || index.row() >= m_slides.count())
        return QVariant();

    const SlideData &slide = m_slides[index.row()];
    if (role == NameRole)
        return slide.name();
    else if (role == ImageIdRole)
        return slide.imageId();

    return QVariant();
}

QHash<int, QByteArray> DeclarativeSlideModel::roleNames() const  {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "slideName";
    roles[ImageIdRole] = "imageId";
    return roles;
}

QImage DeclarativeSlideModel::getImageById(const QString &id) const {
    for (const SlideData &slide : m_slides) {
        if (slide.imageId() == id) {
            return slide.image();
        }
    }
    return QImage();
}

SlideData DeclarativeSlideModel::getSlide(int index) {
    if (m_slides.length() > index && index >= 0)
        return m_slides.at(index);

    // default
    return SlideData();
}

void DeclarativeSlideModel::setSlide(int index, SlideData slide) {
    if (m_slides.length() > index && index >= 0) {
        m_slides.replace(index, slide);
    }
}

