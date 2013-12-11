//
//  LifeView.h
//  iPad_Life
//
//  Created by Tony Jefferson_old on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeWorld.h" // for the DELAY

@interface LifeView : UIView {
	float cellWidth;
	float cellHeight;
	int* currentState; // points at an array of ints
	CGImageRef cellImageRef; // for use with CoreGraphics functions
}
@property (nonatomic,assign)int* currentState; // int* points at first element of array
- (void)calculateCellSize;
@end
