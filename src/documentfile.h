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

#ifndef DOCUMENTFILE_H
#define DOCUMENTFILE_H
#include <QJsonArray>
#include <QJsonObject>
#include <QString>
#include <QUrl>
#include <QVariantMap>
#include "slidedata.h"

class DocumentFile
{
public:
    DocumentFile();
    void addObject(const QVariantMap &properties);
    void save(QUrl url);

    static SlideData load(QUrl url);

private:
    QJsonArray jsonArray;
};

#endif // DOCUMENTFILE_H
