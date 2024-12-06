// SPDX-License-Identifier: GPL-2.0-or-later
// Stage - a simple presentation application
// Copyright (C) Vesa-Matti Hartikainen <vesku.h@gmail.com>

#include "macsymbolimageprovider.h"
#include <QImage>
#include <QDebug>
#ifdef Q_OS_MACOS
#import <Cocoa/Cocoa.h>
#endif


MacSymbolImageProvider::MacSymbolImageProvider(): QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage MacSymbolImageProvider::requestImage(const QString &name, QSize *size, const QSize &requestedSize)
{
#ifdef Q_OS_MACOS
    @autoreleasepool {
        NSString *symbolName = [NSString stringWithUTF8String: name.toUtf8().constData()];

        NSImageSymbolConfiguration *config = [NSImageSymbolConfiguration configurationWithPointSize:20
                                                                                             weight:NSFontWeightRegular];

        NSImage *nsImage = [NSImage imageWithSystemSymbolName:symbolName accessibilityDescription:nil];
        if (!nsImage) {
            qWarning() << "Failed to load SF Symbol:" << name;
            return QImage();
        }

        nsImage = [nsImage imageWithSymbolConfiguration:config];

        // Determine desired size
        NSSize desiredSize;
        if (requestedSize.isValid() && requestedSize.width() > 0 && requestedSize.height() > 0) {
            desiredSize = NSMakeSize(requestedSize.width(), requestedSize.height());
        } else {
            desiredSize = [nsImage size];
        }
        [nsImage setSize:desiredSize];

        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc]
            initWithBitmapDataPlanes:NULL
                          pixelsWide:desiredSize.width
                          pixelsHigh:desiredSize.height
                       bitsPerSample:8
                     samplesPerPixel:4
                            hasAlpha:YES
                            isPlanar:NO
                      colorSpaceName:NSCalibratedRGBColorSpace
                         bytesPerRow:0
                        bitsPerPixel:0];
        if (!bitmapRep) {
            qWarning() << "Failed to create bitmap representation for symbol:" << name;
            return QImage();
        }

        // Create a graphics context and render the NSImage into it
        NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep:bitmapRep];
        if (!context) {
            qWarning() << "Failed to create graphics context for symbol:" << name;
            return QImage();
        }
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:context];


        [nsImage drawAtPoint:NSZeroPoint
                    fromRect:NSMakeRect(0, 0, desiredSize.width, desiredSize.height)
                   operation:NSCompositingOperationSourceOver
                    fraction:1.0];

        [NSGraphicsContext restoreGraphicsState];

        QImage qImage(reinterpret_cast<const uchar*>([bitmapRep bitmapData]),
                      bitmapRep.pixelsWide,
                      bitmapRep.pixelsHigh,
                      bitmapRep.bytesPerRow,
                      QImage::Format_ARGB32_Premultiplied);

        qImage.invertPixels();
        QImage copiedImage = qImage.copy(); // Ensure the image data is retained

        if (size) {
            *size = QSize(bitmapRep.pixelsWide, bitmapRep.pixelsHigh);
        }

        return copiedImage;
    }
#else
    // For other platforms, return an empty image or a placeholder
    Q_UNUSED(name);
    Q_UNUSED(size);
    Q_UNUSED(requestedSize);
    return QImage();
#endif
}
