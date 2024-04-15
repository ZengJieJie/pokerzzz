//
//  GameBoard.m
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/13.
//

#import "GameBoard.h"
#import <Foundation/Foundation.h>


@implementation GameBoard

- (instancetype)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns {
    self = [super init];
    if (self) {
        _rows = rows;
        _columns = columns;
        _board = [NSMutableArray arrayWithCapacity:rows];
    }
    return self;
}

- (void)initializeBoard {
    for (NSUInteger i = 0; i < self.rows; i++) {
        NSMutableArray<NSNumber *> *row = [NSMutableArray arrayWithCapacity:self.columns];
        for (NSUInteger j = 0; j < self.columns; j++) {
            // 随机生成1到9之间的数字作为初始值
            NSNumber *number = [NSNumber numberWithUnsignedInteger:(arc4random_uniform(9) + 1)];
            [row addObject:number];
        }
        [self.board addObject:row];
    }
}

- (void)printBoard {
    for (NSMutableArray<NSNumber *> *row in self.board) {
        NSMutableString *rowString = [NSMutableString string];
        for (NSNumber *number in row) {
            [rowString appendFormat:@"%@ ", number];
        }
        NSLog(@"%@", rowString);
    }
}

@end





