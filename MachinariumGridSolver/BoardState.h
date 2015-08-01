
//
//  BoardState.h
//  MachinariumGridSolver
//
//  Created by Aaron Golden on 7/31/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#ifndef MachinariumGridSolver_BoardState_h
#define MachinariumGridSolver_BoardState_h

typedef enum {
    Off,
    On,
    Red
} State;

typedef State Board[5][5];

typedef struct {
    int x, y;
} BoardLocation;

typedef BoardLocation Solution[25];

#endif
