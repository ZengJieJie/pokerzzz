//
//  MPUserInfoModel.m
//  MissPokerGame
//
//  Created by mac on 2024/3/27.
//

#import "MPUserInfoModel.h"

@implementation MPUserInfoModel

+(MPUserInfoModel *)createAddUserModel {
    MPUserInfoModel *model = [MPUserInfoModel new];
    model.isAddUserButton = YES;
    return model;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    MPUserInfoModel * info = [[MPUserInfoModel alloc] init];
    info.userName = [self.userName copy];
    info.isAddUserButton = self.isAddUserButton;
    return info;;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeBool:self.isAddUserButton forKey:@"isAddUserButton"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.isAddUserButton = [aDecoder decodeBoolForKey:@"isAddUserButton"];
    }
    return self;
}
@end
