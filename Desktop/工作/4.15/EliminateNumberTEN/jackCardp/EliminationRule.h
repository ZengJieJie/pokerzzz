//
//  EliminationRule.h
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 定义消除规则类
@interface EliminationRule : NSObject

@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *board; // 游戏面板
@property (nonatomic, assign) NSUInteger score; // 得分

- (instancetype)initWithBoard:(NSMutableArray<NSMutableArray<NSNumber *> *> *)board;
- (void)eliminateNumbersWithSelectedNumber:(NSNumber *)selectedNumber; // 消除数字

@end

NS_ASSUME_NONNULL_END
