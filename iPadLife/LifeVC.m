//
//  LifeVC.m
//  iPadLife
//
//  Created by Gordon Leete on 12/3/13.
//  Copyright (c) 2013 Gordon Leete. All rights reserved.
//

#import "LifeVC.h"
#import "LifeWorld.h"
#import "LifeView.h"

@interface LifeVC ()

@end

@implementation LifeVC

#pragma mark Gesture Action Methods

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)sender{
	if(sender.rotation > 0.25){ // 1/4 radian = 14.3 degrees
		[self stepWorld];
	}
}
#pragma mark -


#pragma mark Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		world = [[LifeWorld alloc] init];
		[self randomizeWorld];
    }
    return self;
}
#pragma mark -

#pragma mark Getters
-(int)generation{
	return world.generation;
}
#pragma mark -

#pragma mark World Controllers
- (void)stepWorld{
	[world stepWorld];
	[(LifeView *)self.view setCurrentState: world.currentState];
	[(LifeView *)self.view setNeedsDisplay];
}

- (void)randomizeWorld{
	[world randomizeWorld];
	[(LifeView *)self.view setCurrentState: world.currentState];
	[(LifeView *)self.view setNeedsDisplay];
}

- (void)startWorld{
	NSLog(@"startSim [timer isValid]=%d",[timer isValid]);
	if (![timer isValid]) {
		timer = [NSTimer scheduledTimerWithTimeInterval:.04
                                                 target:self
                                               selector:@selector(stepWorld)
                                               userInfo:nil
                                                repeats:YES];
	}
	
}

- (void)stopWorld{
	NSLog(@"stopSim [timer isValid]=%d",[timer isValid]);
	if([timer isValid]){
		[timer invalidate];
		timer = nil;
	}
}
#pragma mark -

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    // Tell LifeView to refresh itself soon
    [(LifeView *)self.view setNeedsDisplay];
    
    // Calculate size of cells in pixels
	[(LifeView *)self.view calculateCellSize];
    
    
    //  Create a tap recognizer and add it to the view.
    UITapGestureRecognizer *tapRecognizer;
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(randomizeWorld)];
    
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapRecognizer];
	
    //  Create swipe gesture recognizers
    UISwipeGestureRecognizer *swipeRecognizer;
	
    // Swipe right (the default) to startWorld
    swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(startWorld)];
    [self.view addGestureRecognizer:swipeRecognizer];
    
    // left swipes will call stopWorld
    swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(stopWorld)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
	
    //  Create a rotation gesture recognizer.
    UIRotationGestureRecognizer *rotationRecognizer;
    
    rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
    [self.view addGestureRecognizer:rotationRecognizer];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
