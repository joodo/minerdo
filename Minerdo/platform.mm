#import "platform.h"

#import <Cocoa/Cocoa.h>

void hideTitleBar(QQuickWindow *w)
{
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSWindow* window = [(NSView*)w->winId() window];

    window.styleMask = window.styleMask | NSWindowStyleMaskFullSizeContentView;
    window.titlebarAppearsTransparent = YES;
    window.titleVisibility = NSWindowTitleHidden;
    //[window setMovableByWindowBackground:YES];
    //[pool release];
}

void setAlwaysOnTop(QWindow *window, bool alwaysOnTop)
{
    auto nsWindow = [(NSView*)window->winId() window];
    if (alwaysOnTop) {
        nsWindow.level = NSModalPanelWindowLevel;
    } else {
        nsWindow.level = NSNormalWindowLevel;
    }
}
