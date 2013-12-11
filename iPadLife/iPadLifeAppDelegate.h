//
//  iPadLifeAppDelegate.h
//  iPadLife
//
//  Created by Gordon Leete on 12/3/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlsVC.h"
#import "LifeVC.h"

@interface iPadLifeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UISplitViewController *splitVC;

@end
