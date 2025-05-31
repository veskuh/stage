// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "declarativedocument.h"
#include "declarativeclipboard.h"
#include "declarativeslidemodel.h"
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include "macsymbolimageprovider.h"
#include "QQmlContext"
#include "slidepreviewimageprovider.h"
#include "stageapplication.h"


int main(int argc, char *argv[])
{
    StageApplication app(argc, argv);
    app.setOrganizationName("Stage");
    app.setOrganizationDomain("veskuh.net");
    app.setApplicationName("Stage");

    QQmlApplicationEngine engine;
    qmlRegisterType<DeclarativeDocument>("com.mac.vesku.stage", 1, 0, "Document");
    qmlRegisterType<DeclarativeClipboard>("com.mac.vesku.stage", 1, 0, "Clipboard");
    qmlRegisterType<DeclarativeSlideModel>("com.mac.vesku.stage", 1, 0, "SlideModel");

    engine.addImageProvider("slideProvider", new SlidePreviewImageProvider());

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

    QObject::connect(&app, &StageApplication::openUrl, [topLevel](const QUrl url){
        QMetaObject::invokeMethod(topLevel, "openFile", Q_ARG(QVariant, url));
    });

    window->show();
    return app.exec();
}
