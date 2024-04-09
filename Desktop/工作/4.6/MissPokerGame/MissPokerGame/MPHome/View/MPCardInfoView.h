//
//  MPCardInfoView.h
//  MissPokerGame
//
//  Created by mac on 2024/4/5.
//

#import <UIKit/UIKit.h>
#import "MPPokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCardInfoView : UIView
- (void)updateCardInfo:(MPPokerCardModel*)cardInfo;
@end

NS_ASSUME_NONNULL_END
