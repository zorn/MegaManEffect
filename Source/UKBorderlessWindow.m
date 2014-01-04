//
//  UKBorderlessWindow.m
//  Filie
//
//  Created by Uli Kusterer on Fri Dec 19 2003.
//  Copyright (c) 2003 M. Uli Kusterer. All rights reserved.
//

#import "UKBorderlessWindow.h"


@implementation UKBorderlessWindow

// Designated Initializer:
-(id)   initWithContentRect: (NSRect)box styleMask: (unsigned int)sty backing: (NSBackingStoreType)bs defer: (BOOL)def
{
	self = [super initWithContentRect:box styleMask: NSBorderlessWindowMask backing:bs defer: def];
	
	if( self != nil )
	{
		constrainRect = NO;
	}
	
	return self;
}


// Convenience initializer:
-(id)   initWithContentRect: (NSRect)box backing: (NSBackingStoreType)bs defer: (BOOL)def
{
	return [self initWithContentRect: box styleMask: NSBorderlessWindowMask backing: bs defer: def];
}

// Borderless window by default return NO here, but we want a regular window:
-(BOOL) canBecomeKeyWindow
{
    return YES;
}

// Make sure our borderless window may even cover the menu bar if we desire so.
-(NSRect)   constrainFrameRect:(NSRect)frameRect toScreen:(NSScreen *)screen
{
	if( !constrainRect )
		return frameRect;
	else
		return [super constrainFrameRect: frameRect toScreen: screen];
}


-(BOOL)	constrainRect
{
    return constrainRect;
}

-(void)	setConstrainRect: (BOOL)newConstrainRect
{
	constrainRect = newConstrainRect;
}


@end
