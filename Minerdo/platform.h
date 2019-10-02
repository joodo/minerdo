#ifndef PLATFORM_H
#define PLATFORM_H

#include <QQuickWindow>

#ifdef Q_OS_MACOS
void hideTitleBar(QQuickWindow* window);
#endif

#endif // PLATFORM_H
