//
//  MPUserInfoModel.h
//  MissPokerGame
//
//  Created by mac on 2024/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPUserInfoModel : NSObject<NSCoding,NSCopying>
@property (nonatomic ,copy)NSString *userName;
@property (nonatomic ,assign)BOOL isAddUserButton;

+(MPUserInfoModel *)createAddUserModel;
@end

NS_ASSUME_NONNULL_END
