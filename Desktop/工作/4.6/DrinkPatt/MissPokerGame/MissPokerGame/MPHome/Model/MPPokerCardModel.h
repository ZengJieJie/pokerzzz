//
//  MPPokerCardModel.h
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPPokerCardModel : NSObject
@property (nonatomic ,copy)NSString *cardNumber;
@property (nonatomic ,copy)NSString *cardName;
@property (nonatomic ,copy)NSString *cardFlowerColor;
@property (nonatomic ,copy)NSString *cardRule;

+(NSArray<MPPokerCardModel*> *)defaultCardList;

+ (NSMutableArray *)sortedRandomArrayByArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
