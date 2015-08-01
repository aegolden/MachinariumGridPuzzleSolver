//
//  AppDelegate.m
//  MachinariumGridSolver
//
//  Created by Aaron Golden on 7/31/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#import "AppDelegate.h"

#import "BoardView.h"
#import "BoardState.h"
#import "BoardSolver.h"


@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet BoardView *view;
- (IBAction)solve:(id)sender;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (IBAction)solve:(id)sender {
    Board board;
    [_view getBoard:board];

    Solution solution;
    if (SolveBoard(board, solution, 0)) {
        [_view setSolution:solution];
    } else {
        NSLog(@"Failed to solve");
    }
}

@end
