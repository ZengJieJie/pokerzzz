//
//  MPBaseViewController.m
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import "MPBaseViewController.h"

@interface MPBaseViewController ()

@end

@implementation MPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.navView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backButton];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset([UIApplication sharedApplication].keyWindow.safeAreaInsets.top);
        make.height.mas_equalTo(44);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navView.mas_left).offset(15);
        make.centerY.equalTo(self.navView.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.navView);
    }];
}

-(void)backButtonClick:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _navView.backgroundColor = UIColor.clearColor;
    }
    return _navView;
}
-(UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
            lable.textColor = UIColor.whiteColor;
            lable.textAlignment = NSTextAlignmentCenter;
            lable;
        });
    }
    return _titleLabel;
}

-(UIButton *)backButton
{
    if(!_backButton){
        _backButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular]];
            button;
        });
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
@end
