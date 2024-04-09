//
//  MPUserInfoCell.m
//  MissPokerGame
//
//  Created by mac on 2024/3/24.
//

#import "MPUserInfoCell.h"

@interface  MPUserInfoCell()<UITextFieldDelegate>
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIImageView *headImageView;
@property (nonatomic ,strong)UITextField *userNameTextField;
@property (nonatomic ,strong)MPUserInfoModel *userInfoModel;
@end

@implementation MPUserInfoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self resizeCustomView];
    }
    return self;
}


-(void)resizeCustomView
{
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.headImageView];
    [self.bgView addSubview:self.userNameTextField];
    [self.bgView addSubview:self.removeUserButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.right.equalTo(self.removeUserButton.mas_left).offset(-15);
        make.height.mas_equalTo(30);
    }];
    [self.removeUserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)updateThemeColor:(UIColor*)color {
    self.bgView.layer.borderColor = color.CGColor;
    self.headImageView.tintColor = color;
//    self.removeUserButton.tintColor = color;
    self.headImageView.layer.shadowColor = [color colorWithAlphaComponent:1].CGColor;
    self.userNameTextField.textColor = color;
    self.userNameTextField.tintColor = color;
}

- (void)userNameTextFieldTextChange:(UITextField *)sender {
    self.userInfoModel.userName = sender.text;
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _bgView.layer.borderWidth = 2;
        _bgView.layer.cornerRadius = 15;
    }
    return _bgView;
}
-(UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
        _headImageView.image = [[UIImage imageNamed:@"ziyuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIBezierPath * shadowPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 23) radius:30 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _headImageView.layer.shadowPath = shadowPath.CGPath;
        _headImageView.layer.shadowOpacity = 0.3;
    }
    return _headImageView;
}
-(UITextField*)userNameTextField
{
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"Player"];
        attr.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        attr.color = UIColor.darkGrayColor;
        _userNameTextField.attributedPlaceholder = attr;
        [_userNameTextField addTarget:self action:@selector(userNameTextFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
        _userNameTextField.delegate = self;
    }
    return _userNameTextField;
}

-(UIImageView *)removeUserButton
{
    if(!_removeUserButton){
        _removeUserButton = ({
            UIImageView *button = [[UIImageView alloc] init];
//            [button setImage:[[UIImage imageNamed:@"shanchu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [button setImage:[UIImage imageNamed:@"shanchu"]];
            button.userInteractionEnabled = YES;
            button;
        });
    }
    return _removeUserButton;
}

- (void)updateUserInfoModel:(MPUserInfoModel *)userInfoModel {
    self.userInfoModel = userInfoModel;
    self.userNameTextField.text = userInfoModel.userName;
}
@end
