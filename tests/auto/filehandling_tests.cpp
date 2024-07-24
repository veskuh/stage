#include <catch2/catch.hpp>
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

