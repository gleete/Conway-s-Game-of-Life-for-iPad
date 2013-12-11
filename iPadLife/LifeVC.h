//
//  LifeVC.h
//  iPadLife
//
//  Created by Gordon Leete on 12/3/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeWorld.h"
#import "LifeView.h"

@interface LifeVC : UIViewController {
	LifeWorld *world;
	NSTimer *timer;
}
@property(nonatomic,readonly)int generation;
- (void)startWorld;
- (void)stopWorld;
- (void)randomizeWorld;
- (void)stepWorld;

@end
