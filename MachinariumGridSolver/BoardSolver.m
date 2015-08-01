//
//  BoardSolver.m
//  MachinariumGridSolver
//
//  Created by Aaron Golden on 7/31/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BoardState.h"

void CopyBoard(Board dst, Board src) {
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            dst[j][k] = src[j][k];
        }
    }
}

BOOL BoardIsSolved(Board board) {
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            if (board[j][k] == Off) {
                return NO;
            }
        }
    }
    return YES;
}

BOOL BoardHasNoMoves(Board board) {
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            if (board[j][k] == On) {
                return NO;
            }
        }
    }
    return YES;
}

BOOL SpawnArrows(Board board, int j, int k) {
    // Kill any left over arrows.
    for (int j = 0; j < 5; j++) {
        for (int k = 0; k < 5; k++) {
            if (board[j][k] == Left ||
                board[j][k] == Right ||
                board[j][k] == Up ||
                board[j][k] == Down) {
                board[j][k] = Off;
            }
        }
    }

    // Create arrows around the active point.
    int arrowCount = 0;
    if (j > 0 && board[j - 1][k] == Off) {
        board[j - 1][k] = Left;
        arrowCount++;
    }
    if (j < 4 && board[j + 1][k] == Off) {
        board[j + 1][k] = Right;
        arrowCount++;
    }
    if (k > 0 && board[j][k - 1] == Off) {
        board[j][k - 1] = Up;
        arrowCount++;
    }
    if (k < 4 && board[j][k + 1] == Off) {
        board[j][k + 1] = Down;
        arrowCount++;
    }
    return (arrowCount > 0) || BoardIsSolved(board);
}

BOOL ApplyMove(Board board, int j, int k) {
    if (board[j][k] == Off) {
        board[j][k] = On;
        return SpawnArrows(board, j, k);
    } else if (board[j][k] == Left) {
        board[j][k] = On;
        j--;
        while (j >= 0 && board[j][k] == Off) {
            board[j][k] = On;
            j--;
        }
        return SpawnArrows(board, j + 1, k);
    } else if (board[j][k] == Right) {
        board[j][k] = On;
        j++;
        while (j <= 4 && board[j][k] == Off) {
            board[j][k] = On;
            j++;
        }
        return SpawnArrows(board, j - 1, k);
    } else if (board[j][k] == Up) {
        board[j][k] = On;
        k--;
        while (k >= 0 && board[j][k] == Off) {
            board[j][k] = On;
            k--;
        }
        return SpawnArrows(board, j, k + 1);
    } else if (board[j][k] == Down) {
        board[j][k] = On;
        k++;
        while (k <= 4 && board[j][k] == Off) {
            board[j][k] = On;
            k++;
        }
        return SpawnArrows(board, j, k - 1);
    }

    return NO;
}

BOOL SolveBoard(Board board, Solution solution, int moves) {
    if (BoardIsSolved(board)) {
        return YES;
    }

    if (BoardHasNoMoves(board)) {
        for (int j = 0; j < 5; j++) {
            for (int k = 0; k < 5; k++) {
                if (board[j][k] == Off) {
                    Board newBoard;
                    CopyBoard(newBoard, board);
                    if (ApplyMove(newBoard, j, k)) {
                        solution[moves] = (BoardLocation){ .x = j, .y = k };
                        if (SolveBoard(newBoard, solution, moves + 1)) {
                            return YES;
                        }
                    }
                }
            }
        }
    } else {
        for (int j = 0; j < 5; j++) {
            for (int k = 0; k < 5; k++) {
                if (board[j][k] == Left ||
                    board[j][k] == Right ||
                    board[j][k] == Up ||
                    board[j][k] == Down) {
                    Board newBoard;
                    CopyBoard(newBoard, board);
                    if (ApplyMove(newBoard, j, k)) {
                        solution[moves] = (BoardLocation){ .x = j, .y = k };
                        if (SolveBoard(newBoard, solution, moves + 1)) {
                            return YES;
                        }
                    }
                }
            }
        }
    }

    return NO;
}
