//
//  MPCacheManager.m
//  MissPokerGame
//
//  Created by mac on 2024/3/27.
//

#import "MPCacheManager.h"
@interface MPCacheManager()
@property (nonatomic ,strong)YYCache *cache;
@end
@implementation MPCacheManager
#pragma --mark 单例模式
+ (instancetype)sharedManager {
    
    static MPCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MPCacheManager alloc]init];
    });
    
    return _sharedInstance;
}

-(YYCache *)cache {
    if (!_cache) {
        _cache = [YYCache cacheWithName:@"MPPoker"];
    }
    return _cache;
}

+ (NSArray<MPUserInfoModel *> *)userList {
    return [MPCacheManager objectForKey:@"MPUserList"];
}

+ (void)cacheUserList:(NSArray *)userList{
    [MPCacheManager setObject:userList forKey:@"MPUserList"];
}
+ (nullable id<NSCoding>)objectForKey:(NSString *)key{
    id aa = [[MPCacheManager sharedManager].cache objectForKey:key];
    return [[MPCacheManager sharedManager].cache objectForKey:key];
}

+ (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key{
    [[MPCacheManager sharedManager].cache setObject:object forKey:key];
}
@end
