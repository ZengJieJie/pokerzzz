//
//  MPStartViewController.m
//  MissPokerGame
//
//  Created by mac on 2024/4/7.
//

#import "MPStartViewController.h"
#import "MPHomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MPStartViewController ()
@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,strong)UIImageView *logoImageView;
@property (nonatomic ,strong)UIImageView *logoTwoImageView;
@property (nonatomic ,strong)UIImageView *goPlayImageView;
@end

@implementation MPStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self resizeCustomView];
}

#pragma mark 调整自定义视图
-(void)resizeCustomView
{
    CGFloat biLiX = [UIApplication sharedApplication].keyWindow.width/852.0;
    CGFloat biLiY = [UIApplication sharedApplication].keyWindow.height/393.0;
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.logoTwoImageView];
    [self.view addSubview:self.goPlayImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.mas_equalTo(500 * biLiX);
        make.height.mas_equalTo(280 * biLiY);
    }];
    [self.logoTwoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.centerY.equalTo(self.logoImageView.mas_centerY).offset(0);
        make.width.mas_equalTo(400 * biLiX);
        make.height.mas_equalTo(200 * biLiY);
    }];
    [self.goPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(-15 * biLiX);
        make.top.equalTo(self.logoImageView.mas_bottom).offset(0);
        make.width.mas_equalTo(100 * biLiX);
        make.height.mas_equalTo(33 * biLiY);
    }];
}

- (void)goPlayClick {
    AudioServicesPlaySystemSound(1519);
    [self.navigationController pushViewController:[[MPHomeViewController alloc] init] animated:YES];
}
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startImage1"]];
    }
    return _bgImageView;
}
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startImage2"]];
    }
    return _logoImageView;
}
-(UIImageView *)logoTwoImageView
{
    if (!_logoTwoImageView) {
        _logoTwoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startImage3"]];
    }
    return _logoTwoImageView;
}
-(UIImageView *)goPlayImageView
{
    if (!_goPlayImageView) {
        _goPlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startImage4"]];
        _goPlayImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPlayClick)];
        [_goPlayImageView addGestureRecognizer:tapges];
    }
    return _goPlayImageView;
}
@end
