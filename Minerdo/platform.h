#ifndef PLATFORM_H
#define PLATFORM_H

#include <QQuickWindow>

#ifdef Q_OS_MACOS
void hideTitleBar(QQuickWindow* window);
void setAlwaysOnTop(QWindow *window, bool alwaysOnTop);
#endif

#endif // PLATFORM_H
