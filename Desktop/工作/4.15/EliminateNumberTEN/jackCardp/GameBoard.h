//
//  GameBoard.h
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameBoard : NSObject
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *board; // 游戏面板
@property (nonatomic, assign) NSUInteger rows; // 行数
@property (nonatomic, assign) NSUInteger columns; // 列数

- (instancetype)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns;
- (void)initializeBoard; // 初始化游戏面板
- (void)printBoard; // 打印游戏面板
@end



NS_ASSUME_NONNULL_END
