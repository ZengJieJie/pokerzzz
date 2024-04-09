//
//  MPCacheManager.h
//  MissPokerGame
//
//  Created by mac on 2024/3/27.
//

#import <Foundation/Foundation.h>
#import "MPUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MPCacheManager : NSObject

+ (nullable id<NSCoding>)objectForKey:(NSString *)key;

+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

@property (nonatomic ,strong, class)NSArray<MPUserInfoModel *> *userList;

+ (void)cacheUserList:(NSArray *)userList;
@end

NS_ASSUME_NONNULL_END
