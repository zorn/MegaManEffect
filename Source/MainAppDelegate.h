#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVPlayer.h>
#import <AVKit/AVPlayerView.h>

@interface MainAppDelegate : NSObject <NSApplicationDelegate, NSSoundDelegate>
{
    IBOutlet NSTextField *appName;
	IBOutlet NSImageView *iconView;
    
    IBOutlet NSWindow *animationWindow;
	IBOutlet AVPlayerView *stars;
	IBOutlet NSWindow *strip;
	NSWindow *realAnimationWindow;
    
    NSNotificationCenter *notCenter;	// the NSWorkspace notification center
    NSArray *currentApps;				// a list of the current apps, as of
                                        // launch, or the last time the effect
                                        // was ran.
    
    NSSound *mySound;					// sound effect
    NSTimer *timer;
    
    AVPlayer *myMoviePlayer;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSButton *checkbox;

@end
