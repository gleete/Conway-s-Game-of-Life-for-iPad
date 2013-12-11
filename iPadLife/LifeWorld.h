//
//  LifeWorld.h
//  iPad_Life
//
//  Created by Tony Jefferson_old on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ALIVE 1
#define DEAD 0
#define COLS 60 // 3:4 ratio for portrait
#define ROWS 80 
#define DELAY 1.0/24.0 // 1/FPS for timer

@interface LifeWorld : NSObject {
	int neighbors[ROWS * COLS];
	int currentState[ROWS * COLS];
}
@property (nonatomic,readonly)int generation;
@property (nonatomic,readonly)int* currentState; // int* points at first element of array
- (void)randomizeWorld;
- (void)stepWorld;
- (void)printWorld; // for debugging
@end
