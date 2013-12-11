//
//  LifeWorld.m
//  iPad_Life
//
//  Created by Tony Jefferson_old on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeWorld.h"

@implementation LifeWorld
@synthesize generation;
#pragma mark -
#pragma mark Init
- (id) init{
	self = [super init];
	if (self != nil) {
		[self randomizeWorld];
	}
	return self;
}
#pragma mark -

#pragma mark Getters
- (int*)currentState{
	return currentState;
}
#pragma mark -

#pragma mark Sim Logic
- (void)randomizeWorld{
	generation = 0;
	// seed random number generator
	srandom(time(NULL));
	// randomize starting state
	for(int cellNumber = 0;cellNumber< ROWS*COLS; cellNumber++){
		currentState[cellNumber] = random() % 2 ;
		neighbors[cellNumber]=0;
	}
}

- (void)stepWorld{
	generation ++;
	// Calculate how many neighbors each cell has
	int row,col,numNeighbors=0;
	for(int cellNumber = 0;cellNumber< ROWS*COLS; cellNumber++){
		row = cellNumber/COLS;  // remainder is dropped (truncated)
		col = cellNumber % COLS; // remainder is column number
		if (row > 0 && currentState[cellNumber - COLS] == 1) numNeighbors++; // look N
		if (row > 0 && col < (COLS - 1) && currentState[cellNumber - COLS + 1] == 1) numNeighbors++; // look NE
		if (col < (COLS - 1) && currentState [cellNumber + 1 ] == 1) numNeighbors++; // look E
		if (col < (COLS - 1) && (row < ROWS - 1) && currentState [cellNumber + 1 + COLS ] == 1) numNeighbors++; // look SE
		if (row < (ROWS - 1) && currentState [cellNumber + COLS ] == 1) numNeighbors++; // look S
		if (col > 0 && row < (ROWS - 1) && currentState [cellNumber + COLS - 1 ] == 1) numNeighbors++; // look SW
		if (col > 0 && currentState [cellNumber - 1 ] == 1) numNeighbors++; // look W
		if (col > 0 && row > 0 && currentState [cellNumber - COLS - 1 ] == 1) numNeighbors++; // look NW
		neighbors[cellNumber]=numNeighbors;
		numNeighbors = 0;
	}
	
	// update currentState ivar
	for(int cellNumber = 0;cellNumber< ROWS*COLS; cellNumber++){
		switch (neighbors[cellNumber]) {
			case 2: // stasis
				currentState[cellNumber] = currentState[cellNumber];
				break;
			case 3: // birth
				currentState[cellNumber] = ALIVE;
				break;
			default: // death from loneliness or overcrowding
				currentState[cellNumber] = DEAD;
				break;
		}
	}
}
#pragma mark -

#pragma mark Debug
- (void)printWorld{
	printf("------ Generation #%d ----------\n",generation);
	printf("\n******* currentState #%d *******\n",generation);
//	int row,col;
	for(int cellNumber = 0;cellNumber< ROWS*COLS; cellNumber++){
//		row = floor(cellNumber/COLS);
//		col = cellNumber % COLS;
		if (cellNumber%COLS == 0) printf("\n");
		printf("%d ",currentState[cellNumber]);
		
	}
	printf("\n\n\n******* neighbors #%d *******\n",generation);
	for(int cellNumber = 0;cellNumber< ROWS*COLS; cellNumber++){
//		row = floor(cellNumber/COLS);
//		col = cellNumber % COLS;
		if (cellNumber%COLS == 0) printf("\n");
		printf("%d ",neighbors[cellNumber]);
		
	}
	printf("\n---------------------------------\n\n");
	
}
#pragma mark -

- (void) dealloc{
	// there are no ivars that we have to release
}

@end
