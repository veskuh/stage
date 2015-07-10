/*
Stage - a simple presentation application
Copyright (C) 2013 Vesa-Matti Hartikainen <vesku.h@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
#ifndef DECLARATIVEDOCUMENT_H
#define DECLARATIVEDOCUMENT_H

#include <QObject>
#include <QUrl>
#include <QJsonArray>

class DeclarativeDocument : public QObject
{
    Q_OBJECT
public:
    explicit DeclarativeDocument(QObject *parent = 0);

    Q_INVOKABLE void save(QUrl url);
    Q_INVOKABLE void load(QUrl url);

signals:

public slots:


private:
    QJsonArray types;


};

#endif // DECLARATIVEDOCUMENT_H
