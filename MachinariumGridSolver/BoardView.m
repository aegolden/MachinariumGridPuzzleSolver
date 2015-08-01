//
//  BoardView.m
//  MachinariumGridSolver
//
//  Created by Aaron Golden on 7/31/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView {
    BOOL _hasSolution;
    Solution _solution;
    Board _board;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _hasSolution = NO;
        for (int j = 0; j < 5; j++) {
            for (int k = 0; k < 5; k++) {
                _board[j][k] = Off;
            }
        }
    }
    return self;
}

- (void)setSolution:(Solution)solution {
    for (int j = 0; j < 25; j++) {
        _solution[j] = solution[j];
    }
    _hasSolution = YES;
    [self setNeedsDisplay:YES];
}

- (void)getBoard:(Board)board {
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            board[j][k] = _board[j][k];
        }
    }
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;

    const CGRect selfBounds = self.bounds;
    const CGFloat cellSize = CGRectGetWidth(selfBounds) / 5;
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            switch (_board[j][k]) {
                case Off:
                    CGContextSetFillColorWithColor(context, [NSColor grayColor].CGColor);
                    break;
                case On:
                    CGContextSetFillColorWithColor(context, [NSColor greenColor].CGColor);
                    break;
                case Red:
                    CGContextSetFillColorWithColor(context, [NSColor redColor].CGColor);
                    break;
                default:
                    break;
            }
            CGContextFillRect(context, CGRectMake(j * cellSize, k * cellSize, cellSize, cellSize));
        }
    }

    if (_hasSolution) {
        for (int j = 0; j < 25; j++) {
            const BoardLocation location = _solution[j];
            const CGRect textRect = CGRectInset(CGRectMake(location.x * cellSize, location.y * cellSize, cellSize, cellSize), 20, 20);
            [[NSString stringWithFormat:@"%d", j] drawInRect:textRect withAttributes:nil];
        }
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    const CGRect selfBounds = self.bounds;
    const CGFloat cellSize = CGRectGetWidth(selfBounds) / 5;
    const CGPoint location = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    const int j = location.x / cellSize;
    const int k = location.y / cellSize;
    if (_board[j][k] == Red) {
        _board[j][k] = Off;
    } else if (_board[j][k] == Off) {
        _board[j][k] = Red;
    }
    [self setNeedsDisplay:YES];
}

@end
