/* AppController */

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject
{
    IBOutlet NSButton *checkbox;		// so we can see if the effect is on/off
	IBOutlet NSTextField *appName;
	IBOutlet NSImageView *iconView;
	IBOutlet NSWindow *mainWindow;
	IBOutlet NSWindow *animationWindow;
	IBOutlet NSMovieView *stars;
	IBOutlet NSWindow *strip;
	
	
	NSWindow *realAnimationWindow;
	
	NSNotificationCenter *notCenter;	// the NSWorkspace notification center
	NSArray *currentApps;				// a list of the current apps, as of 
										// launch, or the last time the effect 
										// was ran.
	NSSound *mySound;					// sound effect
	NSTimer *timer;
	NSMovie *myMovie;

}

@end
