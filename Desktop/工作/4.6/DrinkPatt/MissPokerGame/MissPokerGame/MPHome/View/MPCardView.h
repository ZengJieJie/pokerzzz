//
//  MPCardView.h
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import <UIKit/UIKit.h>
#import "MPPokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCardView : UIView
@property (nonatomic ,strong)UIButton *closeButton;
- (void)showCard:(MPPokerCardModel*)cardInfo;
- (void)refreshUI;
@end

NS_ASSUME_NONNULL_END
