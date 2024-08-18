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

#include <catch2/catch.hpp>
#include <QFileInfo>
#include "../../src/documentfile.h"
#include "../../src/svgexport.h"


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

TEST_CASE("Export empty SVG", "[SvgExport]") {

    // Empty file
    SvgExport exporter("test.svg");
    exporter.save();
    QFile file("test.svg");
    REQUIRE(file.exists() == true);
    file.remove();
}

TEST_CASE("Export single rect SVG", "[SvgExport]") {
    // Single Rect
    SvgExport rectExporter("rect.svg");
    QVariantMap properties;
    properties.insert("color", "#0000ff");
    properties.insert("type", "StageRect");
    properties.insert("height", 100);
    properties.insert("width", 200);
    properties.insert("x", 150);
    properties.insert("y", 50);
    properties.insert("z", 0);
    rectExporter.addObject(properties);
    rectExporter.save();

    QFile file2 = QFile("rect.svg");
    REQUIRE(file2.exists() == true);
    file2.remove();
}
