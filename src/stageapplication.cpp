// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "stageapplication.h"
#include <QFileOpenEvent>

StageApplication::StageApplication(int &argc, char **argv)
    : QApplication(argc, argv)
{
}


bool StageApplication::event(QEvent *event)
{
    if (event->type() == QEvent::FileOpen) {
        QFileOpenEvent *openEvent = static_cast<QFileOpenEvent *>(event);
        emit openUrl(openEvent->url());
    }

    return QApplication::event(event);
}
