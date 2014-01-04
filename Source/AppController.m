#import "AppController.h"

@implementation AppController

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
	//NSLog(@"running effect...");
	
	// 	
	// get a list of the applications currently launched 
	NSArray *newCurrentApps = [[NSWorkspace sharedWorkspace] launchedApplications];
	
	// compare it to the previous listing to find the "new" app in the list
	NSEnumerator *e = [newCurrentApps objectEnumerator];
	id someApp;
	while ( (someApp = [e nextObject]) ) {
		if (![currentApps containsObject:someApp]) {
			if ([checkbox state] == NSOnState) {
				//NSLog(@"MME is on, let's do this...");
				
				
				
				// set label to app name
				//NSLog(@"We have detected this app launching: %@", [someApp valueForKey:@"NSApplicationName"]);
				[appName setStringValue:[someApp valueForKey:@"NSApplicationName"]];
				
				// create new NSImage from that app's icon
				NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:[someApp valueForKey:@"NSApplicationPath"]];
				[icon setSize:NSMakeSize(128.0,128.0)];
				[icon retain];
				
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
				[stars gotoBeginning:self];
				[stars start:self];
				
								
			}
			
		}
	}
	
	[newCurrentApps retain];
	[currentApps release];
	currentApps = newCurrentApps;

}

- (void)endEffect
{
	//NSLog(@"end effect");
	timer = [NSTimer scheduledTimerWithTimeInterval:0.05
									 target:self
								   selector:@selector(fadeEffectOut)
								   userInfo:nil
									repeats:YES];
	[timer retain];
}

- (void)fadeEffectOut
{
	//NSLog(@"Current alpha is: %f", [realAnimationWindow alphaValue]);
	if ([realAnimationWindow alphaValue] > 0.0) {
		[realAnimationWindow setAlphaValue:([realAnimationWindow alphaValue] - 0.1)];
		[strip setAlphaValue:([strip alphaValue] - 0.1)];
	} else {
		[timer invalidate];
		[timer release];
	}
}

- (void)sound:(NSSound *)sound didFinishPlaying:(BOOL)aBool
{
	if (aBool) {
		[stars stop:self];
		// when sound is done, endEffect
		[self endEffect];
	}
}


- (void)awakeFromNib
{	
	// Get path to bundle
	//NSString *pathToSoundFile = [[NSBundle mainBundle] bundlePath];
	//NSLog(@"The path to the sound file is: %@", pathToSoundFile);
	
	// create a data object to load the sound file
	//NSData *soundData = [NSData dataWithContentsOfFile:[pathToSoundFile stringByAppendingString:@"/effect_sound.aiff"]];
	//[soundData retain];
	
	mySound = [NSSound soundNamed:@"effect_sound"];
	[mySound retain];
	
	[mySound setDelegate:self];
	
	//mySound = [[NSSound alloc] initWithData:soundData];
	
	// Get notification center
	notCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
	
	// get a list of all currently running applications
	currentApps = [[NSWorkspace sharedWorkspace] launchedApplications];
	[currentApps retain];
	
	// sign up for notifications when applications launch
	[notCenter addObserver:self 
			   selector:@selector(runEffect:)
			   name:NSWorkspaceDidLaunchApplicationNotification
			   object:nil]; // Register for all notifications
	
	NSView *view = [animationWindow contentView];
	[view retain];
	[animationWindow setContentView:nil];
	[realAnimationWindow setContentView:view];
	[view release];
	
	// create movie
	NSString *pathToMovie = [[NSBundle mainBundle] pathForResource:@"stars2" ofType:@"mov"];
	
	//NSLog(@"path to movie: %@", pathToMovie);
	myMovie = [[NSMovie alloc] initWithURL:
		[NSURL fileURLWithPath: pathToMovie]
					   byReference:NO];
	
	//NSLog(@"%@", myMovie);
	
	// set movie to movie view
	[stars setMovie:myMovie];
	[stars start:self];
	[stars stop:self];
	
	[strip setAlphaValue:0.0];
	[strip orderWindow:NSWindowAbove relativeTo:[[stars window] windowNumber]];
	
	
	return;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender 
hasVisibleWindows:(BOOL)flag; 
{
	[mainWindow makeKeyAndOrderFront:self];
	[strip makeKeyAndOrderFront:self];
	//NSLog(@"Let's show the main window.");
	
	return YES;
}

- (void)dealloc
{
	[myMovie release];
	[mySound release];
	[super dealloc];
}





@end
