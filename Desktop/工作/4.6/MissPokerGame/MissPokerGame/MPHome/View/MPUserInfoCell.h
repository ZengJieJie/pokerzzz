//
//  MPUserInfoCell.h
//  MissPokerGame
//
//  Created by mac on 2024/3/24.
//

#import <UIKit/UIKit.h>
#import "MPUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPUserInfoCell : UITableViewCell
@property (nonatomic ,strong)UIImageView *removeUserButton;
- (void)updateThemeColor:(UIColor*)color;
- (void)updateUserInfoModel:(MPUserInfoModel *)userInfoModel;
@end

NS_ASSUME_NONNULL_END
