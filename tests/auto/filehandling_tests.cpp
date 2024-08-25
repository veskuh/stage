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

#include <catch2/catch_all.hpp>
#include <QFileInfo>
#include "../../src/documentfile.h"


TEST_CASE("Initialize", "[DocumentFile]") {
    DocumentFile file;

    REQUIRE(1==1); // empty map
}

TEST_CASE("Load and save shapes.json", "[DocumentFile]") {
    DocumentFile file;

    auto path = QFileInfo("../manual/shapes.json").absoluteFilePath();
    auto data = file.load(QUrl::fromLocalFile(path));
    REQUIRE(data.length() > 0); // JSON file objects

    auto newPath = QFileInfo("./out.json").absoluteFilePath();

    for (const QVariantMap &map : data) {
        file.addObject(map);
    }

    file.save(QUrl::fromLocalFile(newPath));
    auto newData = file.load(QUrl::fromLocalFile(newPath));
    REQUIRE(data.length() == newData.length()); 

    QFile tmpFile(newPath);
    tmpFile.remove(); 
}

