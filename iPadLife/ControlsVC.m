//
//  ControlsVC.m
//  iPadLife
//
//  Created by Gordon Leete on 12/3/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import "ControlsVC.h"

@interface ControlsVC ()

@end

@implementation ControlsVC


@synthesize lifeVC;

#pragma mark - Action Methods
- (IBAction)start{
	[self.lifeVC startWorld];
}

- (IBAction)stop{
	[self.lifeVC stopWorld];
}

- (IBAction)reset{
	[self.lifeVC randomizeWorld];
}

- (IBAction)step{
	[self.lifeVC stepWorld];
}
#pragma mark -


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
