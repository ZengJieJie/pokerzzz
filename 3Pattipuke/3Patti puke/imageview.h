//
//  imageview.h
//  3Patti puke
//
//  Created by adin on 2024/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface imageview : UIView
@property (nonatomic, assign) NSInteger value;
- (instancetype)initWithFrame:(CGRect)frame value:(NSInteger)value;
@end

NS_ASSUME_NONNULL_END
