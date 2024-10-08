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

#include "declarativedocument.h"
#include "declarativeclipboard.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "macsymbolimageprovider.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("Stage");
    app.setOrganizationDomain("veskuh.net");
    app.setApplicationName("Stage");

    QQmlApplicationEngine engine;
    qmlRegisterType<DeclarativeDocument>("com.mac.vesku.stage", 1, 0, "Document");
    qmlRegisterType<DeclarativeClipboard>("com.mac.vesku.stage", 1, 0, "Clipboard");


#ifdef Q_OS_MACOS
    engine.addImageProvider("macSymbol", new MacSymbolImageProvider());
#endif

    engine.load(QString::fromLatin1("qrc:/qml/Stage.qml"));
    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    if (!window) {
        qWarning("Root has to be a Window");
        return -1;
    }

    window->show();
    return app.exec();
}
