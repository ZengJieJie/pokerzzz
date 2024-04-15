
#import "EliminationRule.h"
#import <Foundation/Foundation.h>


@implementation EliminationRule

- (instancetype)initWithBoard:(NSMutableArray<NSMutableArray<NSNumber *> *> *)board {
    self = [super init];
    if (self) {
        _board = board;
        _score = 0;
    }
    return self;
}

- (void)eliminateNumbersWithSelectedNumber:(NSNumber *)selectedNumber {
    // 遍历游戏面板，消除与选定数字相加等于10的其他数字单元
    NSMutableArray *rowsToRemove = [NSMutableArray array];
    for (NSUInteger row = 0; row < self.board.count; row++) {
        NSMutableArray<NSNumber *> *currentRow = self.board[row];
        NSMutableArray *indexesToRemove = [NSMutableArray array];
        for (NSUInteger col = 0; col < currentRow.count; col++) {
            NSNumber *currentNumber = currentRow[col];
            if (
                [currentNumber unsignedIntegerValue] + [selectedNumber unsignedIntegerValue] == 10) {
                [indexesToRemove addObject:@(col)];
                self.score++; // 消除得分加1
            }
        }
        if (indexesToRemove.count > 0) {
            [rowsToRemove addObject:@(row)];
            for (NSNumber *index in indexesToRemove) {
                [currentRow removeObjectAtIndex:[index unsignedIntegerValue]];
            }
        }
    }
    
    // 移除符合消除条件的行
    for (NSNumber *index in [rowsToRemove reverseObjectEnumerator]) {
        [self.board removeObjectAtIndex:[index unsignedIntegerValue]];
    }
    
    
    // 添加新的数字单元
    for (NSUInteger row = 0; row < rowsToRemove.count; row++) {
        NSMutableArray<NSNumber *> *newRow = [NSMutableArray array];
        for (NSUInteger i = 0; i < self.board[row].count; i++) {
            NSNumber *number = [NSNumber numberWithUnsignedInteger:(arc4random_uniform(9) + 1)];
            [newRow addObject:number];
        }
        [self.board insertObject:newRow atIndex:0];
    }
    
     
    
    
    NSLog(@"消除与数字 %@ 相加等于10的其他数字单元", selectedNumber);
    NSLog(@"当前面板：%@", self.board);
    NSLog(@"当前得分：%lu", (unsigned long)self.score);
}

@end

