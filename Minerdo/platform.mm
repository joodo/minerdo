#import "platform.h"

#import <Cocoa/Cocoa.h>

void hideTitleBar(QQuickWindow *w)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSWindow* window = [(NSView*)w->winId() window];

    window.styleMask = window.styleMask | NSWindowStyleMaskFullSizeContentView;
    window.titlebarAppearsTransparent = YES;
    window.titleVisibility = NSWindowTitleHidden;
    //[window setMovableByWindowBackground:YES];
    [pool release];
}
