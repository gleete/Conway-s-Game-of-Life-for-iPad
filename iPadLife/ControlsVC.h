//
//  ControlsVC.h
//  iPadLife
//
//  Created by Gordon Leete on 12/3/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LifeVC.h"

@interface ControlsVC : UIViewController {
}
@property (nonatomic, strong) LifeVC *lifeVC;
- (IBAction)start;
- (IBAction)stop;
- (IBAction)reset;
- (IBAction)step;
@end
