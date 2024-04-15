#import <UIKit/UIKit.h>

typedef void (^CustomAlertActionBlock)(void);

@interface CustomAlertView : UIView

@property (nonatomic, copy) CustomAlertActionBlock againActionBlock;
@property (nonatomic, copy) CustomAlertActionBlock returnActionBlock;

@end

