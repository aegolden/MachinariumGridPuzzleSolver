//
//  BoardView.h
//  MachinariumGridSolver
//
//  Created by Aaron Golden on 7/31/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "BoardState.h"

@interface BoardView : NSView

- (void)setSolution:(Solution)solution;
- (void)getBoard:(Board)board;

@end
