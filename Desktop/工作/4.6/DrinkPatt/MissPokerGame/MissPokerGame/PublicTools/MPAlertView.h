//
//  MPAlertView.h
//  MissPokerGame
//
//  Created by mac on 2024/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPAlertView : UIView
- (instancetype)initWithTitle:(NSString*)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle;
@property (nonatomic ,copy)dispatch_block_t closeAction;
@property (nonatomic ,copy)dispatch_block_t confirmAction;
@property (nonatomic ,copy)dispatch_block_t cancelAction;
- (void)show;
@end

NS_ASSUME_NONNULL_END
