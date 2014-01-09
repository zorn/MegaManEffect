#import "MainAppDelegate.h"

@implementation MainAppDelegate

- (id)init
{
	self = [super init];
	
	// Create animationWindow
	realAnimationWindow =
    [[NSWindow alloc] initWithContentRect:NSZeroRect
                                styleMask:NSBorderlessWindowMask
                                  backing:NSBackingStoreBuffered
                                    defer:NO];
	
	return self;
}

- (IBAction)runEffect:(id)sender
{
	// get a list of the applications currently launched
	NSArray *newCurrentApps = [[NSWorkspace sharedWorkspace] launchedApplications];
	
	// compare it to the previous listing to find the "new" app in the list
	NSEnumerator *e = [newCurrentApps objectEnumerator];
	id someApp;
	while ( (someApp = [e nextObject]) ) {
		if (![currentApps containsObject:someApp]) {
			if ([_checkbox state] == NSOnState) {

				// set label to app name
				[appName setStringValue:[someApp valueForKey:@"NSApplicationName"]];
				
				// create new NSImage from that app's icon
				NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:[someApp valueForKey:@"NSApplicationPath"]];
				[icon setSize:NSMakeSize(128.0,128.0)];
				
				[iconView setImage: icon];
				
				// show animation window
				[realAnimationWindow setLevel:NSScreenSaverWindowLevel];
                
				[realAnimationWindow setFrame:[[[NSScreen screens] objectAtIndex:0] frame] display:YES];
				[realAnimationWindow makeKeyAndOrderFront:self];
				[realAnimationWindow setAlphaValue:1.0];
                
				[strip setLevel:NSScreenSaverWindowLevel];
				[strip orderWindow:NSWindowAbove relativeTo:[[stars window] windowNumber]];
				
				// create a
				NSRect stripRect = NSMakeRect(0.0, (NSHeight([[[NSScreen screens] objectAtIndex:0] frame]) / 2 - 103.0), NSWidth([[[NSScreen screens] objectAtIndex:0] frame]), 206.0);
				
				[strip setFrame:stripRect display:YES];
				[strip makeKeyAndOrderFront:self];
				[strip setAlphaValue:1.0];
                
				// play sound
				[mySound play];
				
				//play movie
                [stars setFrame:NSMakeRect(0.0, 0.0,
                                           NSWidth([[[NSScreen screens] objectAtIndex:0] frame]),
                                           NSHeight([[[NSScreen screens] objectAtIndex:0] frame]))];
                
                [stars.player seekToTime:CMTimeMakeWithSeconds(0.0f, NSEC_PER_SEC) toleranceBefore: kCMTimeZero toleranceAfter: kCMTimeZero];
                
				[stars.player play];
			}
		}
	}
	currentApps = newCurrentApps;
}

- (void)endEffect
{
	timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                            target:self
                                            selector:@selector(fadeEffectOut)
                                            userInfo:nil
                                            repeats:YES];
}

- (void)fadeEffectOut
{
	if ([realAnimationWindow alphaValue] > 0.0) {
		[realAnimationWindow setAlphaValue:([realAnimationWindow alphaValue] - 0.1)];
		[strip setAlphaValue:([strip alphaValue] - 0.1)];
	} else {
		[timer invalidate];
	}
}

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)aBool
{
	if (aBool) {
		[stars.player pause];
		// when sound is done, endEffect
		[self endEffect];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	mySound = [NSSound soundNamed:@"effect_sound"];
	[mySound setDelegate:self];
	
	// Get notification center
	notCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
	
	// get a list of all currently running applications
	currentApps = [[NSWorkspace sharedWorkspace] launchedApplications];
	
	// sign up for notifications when applications launch
	[notCenter addObserver:self
                  selector:@selector(runEffect:)
                      name:NSWorkspaceDidLaunchApplicationNotification
                    object:nil]; // Register for all notifications
	
	NSView *view = [animationWindow contentView];
	[animationWindow setContentView:nil];
	[realAnimationWindow setContentView:view];
	
	// create movie
	NSString *pathToMovie = [[NSBundle mainBundle] pathForResource:@"stars2" ofType:@"mov"];

    myMoviePlayer = [[AVPlayer alloc] initWithURL:
                     [NSURL fileURLWithPath: pathToMovie]];
	
	// set movie to movie view
    stars.player = myMoviePlayer;
    
	[strip setAlphaValue:0.0];
    [strip setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"strip.png"]]];

	[strip orderWindow:NSWindowAbove relativeTo:[[stars window] windowNumber]];
	
    [_window makeKeyAndOrderFront:self];
	return;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender
                    hasVisibleWindows:(BOOL)flag;
{
	[_window makeKeyAndOrderFront:self];
	[strip makeKeyAndOrderFront:self];
	
	return YES;
}

@end
