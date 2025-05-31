// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#ifndef STAGEAPPLICATION_H
#define STAGEAPPLICATION_H

#include <QApplication>
#include <QUrl>

class StageApplication : public QApplication
{
    Q_OBJECT

public:
    StageApplication(int &argc, char **argv);

    bool event(QEvent *event) override;

signals:
    void openUrl(QUrl url);

};

#endif // STAGEAPPLICATION_H
