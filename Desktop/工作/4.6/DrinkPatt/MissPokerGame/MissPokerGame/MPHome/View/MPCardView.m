//
//  MPCardView.m
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import "MPCardView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MPCardView()
@property (nonatomic ,strong)UIView *cardView;
@property (nonatomic ,strong)UIImageView *frontImageView;
@property (nonatomic ,strong)UIImageView *backImageView;
@end
@implementation MPCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self resizeCustomView];
    return self;
}

#pragma mark 调整自定义视图
-(void)resizeCustomView
{
    
    CGFloat biLiX = [UIApplication sharedApplication].keyWindow.width/852.0;
    CGFloat biLiY = [UIApplication sharedApplication].keyWindow.height/393.0;
    
    self.cardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170/1.5*biLiX, 222/1.5*biLiY)];
//    self.cardView.backgroundColor = [UIColor whiteColor]; // 扑克牌的背面颜色
    self.cardView.layer.cornerRadius = 10.0; // 扑克牌的圆角
    self.cardView.layer.masksToBounds = YES;
    [self addSubview:self.cardView];
    
    // 创建一个 UIImageView 来代表扑克牌的正面
    UIImageView *frontImageView = [[UIImageView alloc] initWithFrame:self.cardView.bounds];
    frontImageView.image = [UIImage imageNamed:@"A1"]; // 扑克牌的正面图片
    frontImageView.layer.cornerRadius = 10.0;
    frontImageView.layer.masksToBounds = YES;
    frontImageView.hidden = YES;
    [frontImageView setContentMode:UIViewContentModeScaleToFill];
    self.frontImageView = frontImageView;
    
    
    // 创建一个 UIImageView 来代表扑克牌的背面
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.cardView.bounds];
    backImageView.image = [UIImage imageNamed:@"A1bg"]; // 扑克牌的背面图片
    backImageView.layer.cornerRadius = 10.0;
    backImageView.layer.masksToBounds = YES;
    backImageView.hidden = NO;
    self.backImageView = backImageView;
    
    
    [self.cardView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cardView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.cardView addSubview:frontImageView];
    [frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cardView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addSubview:self.closeButton];
    [self refreshUI];
}
- (void)refreshUI {
    
    CGFloat biLiX = [UIApplication sharedApplication].keyWindow.width/852.0;
    CGFloat biLiY = [UIApplication sharedApplication].keyWindow.height/393.0;
    
    [self.cardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-10 *biLiY);
        make.size.mas_equalTo(self.cardView.size);
    }];
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardView.mas_centerX);
        make.top.equalTo(self.cardView.mas_bottom).offset(40 * biLiY);
        make.height.mas_equalTo(50 * biLiY);
        make.width.mas_equalTo(494*0.2857 * biLiX);
    }];
}
-(BOOL)isLandscape {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}
#pragma mark ---------- Life Cycle ----------
#pragma mark ---------- API Manager ----------
#pragma mark ---------- Delegate ----------
#pragma mark ---------- Private Method ----------
- (void)showCard:(MPPokerCardModel*)cardInfo{
    [self.frontImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",cardInfo.cardFlowerColor,cardInfo.cardNumber]]];
    AudioServicesPlaySystemSound(1519);
    // 创建翻转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.fromValue = @(0); // 初始角度为0
    rotationAnimation.toValue = @(M_PI*2); // 最终角度为180度
    rotationAnimation.duration = 0.5; // 动画时长
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 创建翻牌动画
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    flipAnimation.fromValue = @(0); // 初始角度为0
    flipAnimation.toValue = @(M_PI*2); // 最终角度为180度
    flipAnimation.duration = 0.5; // 动画时长
    flipAnimation.beginTime = 0.5; // 延迟0.5秒开始动画，与翻转动画同时进行
    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 放大缩小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    scaleAnimation.duration = 1; // 动画时长
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    // 设置动画结束后保持最终状态
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[rotationAnimation,flipAnimation,scaleAnimation];
    
    [self.cardView.layer addAnimation:group forKey:@"group"];
    
    // 延迟2秒 等待埋点框架初始化完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 交换正面和背面图片显示状态
        self.frontImageView.hidden = NO;
        self.backImageView.hidden = YES;
    });
}

#pragma mark ---------- Event Response ----------
#pragma mark ---------- Getters and Setters ----------
-(UIButton *)closeButton
{
    if(!_closeButton){
        _closeButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 12, 0)];
            [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [button setTitle:@"Continue" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
            [button setBackgroundImage:[UIImage imageNamed:@"commonButtonBg"] forState:UIControlStateNormal];
            button;
        });
    }
    return _closeButton;
}
@end
