//
//  UKBorderlessWindow.h
//  Filie
//
//  Created by Uli Kusterer on Fri Dec 19 2003.
//  Copyright (c) 2003 M. Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UKBorderlessWindow : NSPanel
{
	BOOL	constrainRect;
}

-(id)   initWithContentRect: (NSRect)box backing: (NSBackingStoreType)bs defer: (BOOL)def;

-(void) setConstrainRect: (BOOL)n;
-(BOOL) constrainRect;

@end
