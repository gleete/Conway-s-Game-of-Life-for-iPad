//
//  LifeView.m
//  iPad_Life
//
//  Created by Tony Jefferson_old on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LifeView.h"

@implementation LifeView
@synthesize currentState;

/*
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
    }
    return self;
}
 */

- (void)awakeFromNib{
	NSLog(@"awakeFromNib");
	// Doing a little init work here
	// we could also do it from viewDidLoad over in the LifeVC viewController
	
	// for use in drawRect if we decide to draw an image instead of a box
	UIImage *image = [UIImage imageNamed:@"smiley_flipped.png"];
	cellImageRef = [image CGImage];
}

- (void)calculateCellSize{
	CGRect bounds = [self bounds];
	// calculate width and height of cells whenever orientation changes
	cellWidth = bounds.size.width / COLS;
	cellHeight = bounds.size.height / ROWS;
}

/*
- (void)drawRect:(CGRect)rect {
    // Get current graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// fill entire background with a color
	CGRect bounds = [self bounds];
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1); // black
	CGContextFillRect(ctx, bounds);
	
	// set some values we will use on all cells
	CGRect cellRect = CGRectMake (0, 0, cellWidth, cellHeight);
	CGContextSetRGBFillColor(ctx, 0, 1, 0, 1); // green
	CGContextSetRGBStrokeColor(ctx, .54, .17, .89, 1); // violet
	CGContextSetLineWidth(ctx, 2.0);
	
	// loop through current state and only draw something if the cell is ALIVE
	int col,row;
	for (int cellNumber=0; cellNumber< COLS * ROWS ; cellNumber++) {
		if (currentState[cellNumber] == ALIVE) {
			 // "push" graphics state
			// many propeties are saved, but we're only interested in CTM
			CGContextSaveGState(ctx);
			
			// calculate row and col and move CTM "pen" to proper cell
			row = cellNumber / COLS;
			col = cellNumber % COLS;
			CGContextTranslateCTM(ctx, col * cellWidth, row * cellHeight);
			
			// draw something in that cell
		//	CGContextFillRect(ctx,cellRect); // rectangle
		//	CGContextStrokeRect(ctx,cellRect); // stroke border of rect
		//	CGContextFillEllipseInRect(ctx, cellRect); // circle
            CGContextDrawImage(ctx,cellRect,cellImageRef); // image
			
			// "pop" graphics state so CTM returns to 0,0
			CGContextRestoreGState(ctx); 
		}
	}
}

*/


// This drawRect uses CGLayers to speed up rendering
// You can also uncomment the 3 lines under "cheap isometric" for a nice effect

- (void)drawRect:(CGRect)rect {
    // Get current graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// fill entire background with a color
	CGRect bounds = [self bounds];
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1.0); // black
	CGContextFillRect(ctx, bounds);
	
	// make a layer
	CGRect cellRect = CGRectMake (0, 0, cellWidth, cellHeight);
	CGLayerRef layerRef = CGLayerCreateWithContext(ctx, CGSizeMake(cellWidth, cellHeight), NULL);
	CGContextRef layerCtx = CGLayerGetContext(layerRef);
	// set some values we will use on all cells
	CGContextSetRGBFillColor(layerCtx, 0, 1, 0, 1); // green
	CGContextSetRGBStrokeColor(layerCtx, .54, .17, .89, 1); // violet
	CGContextSetLineWidth(layerCtx, 2.0);
    //	CGContextFillRect(layerCtx,cellRect); // rectangle
    //	CGContextStrokeRect(layerCtx,cellRect); // stroke border of rect
	//CGContextFillEllipseInRect(layerCtx, cellRect); // circle
	CGContextDrawImage(layerCtx,cellRect,cellImageRef); // image
	
	// cheap isometric
	
     CGContextTranslateCTM(ctx, self.frame.size.width*.5, self.frame.size.width*.3);
     CGContextScaleCTM(ctx, .7, 0.35);
     CGContextRotateCTM(ctx,0.785398163);
    
	
	// loop through current state and only draw something if the cell is ALIVE
	int col,row;
	for (int cellNumber=0; cellNumber< COLS * ROWS ; cellNumber++) {
		if (currentState[cellNumber] == ALIVE) {
            // "push" graphics state
			// many propeties are saved, but we're only interested in CTM
			CGContextSaveGState(ctx);
			
			// calculate row and col and move CTM "pen" to proper cell
			row = cellNumber / COLS;
			col = cellNumber % COLS;
			CGContextTranslateCTM(ctx, col * cellWidth, row * cellHeight);
			CGContextDrawLayerAtPoint(ctx, CGPointMake(0, 0), layerRef);
			
			// "pop" graphics state so CTM returns to 0,0
			CGContextRestoreGState(ctx); 
		}
	}
	CFRelease(layerRef);
}



- (void)dealloc {

}


@end
