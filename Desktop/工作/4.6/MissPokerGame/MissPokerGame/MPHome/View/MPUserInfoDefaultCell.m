//
//  MPUserInfoDefaultCell.m
//  MissPokerGame
//
//  Created by mac on 2024/3/24.
//

#import "MPUserInfoDefaultCell.h"
@interface MPUserInfoDefaultCell()
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIImageView *headImageView;
@property (nonatomic ,strong)UIView *userNameView;
@property (nonatomic ,strong)UIImageView *addUserButton;
@end

@implementation MPUserInfoDefaultCell
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
    [self.bgView addSubview:self.userNameView];
    [self.bgView addSubview:self.addUserButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    [self.addUserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _bgView.layer.borderWidth = 2;
        _bgView.layer.borderColor = UIColor.whiteColor.CGColor;
        _bgView.layer.cornerRadius = 15;
    }
    return _bgView;
}
-(UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = UIColor.lightGrayColor;
        _headImageView.layer.cornerRadius = 22.5f;
    }
    return _headImageView;
}
-(UIView*)userNameView
{
    if (!_userNameView) {
        _userNameView = [[UIView alloc] init];
        _userNameView.backgroundColor = UIColor.lightGrayColor;
        _userNameView.layer.cornerRadius = 7.5f;
    }
    return _userNameView;
}

-(UIImageView *)addUserButton
{
    if(!_addUserButton){
        _addUserButton = ({
            UIImageView *button = [[UIImageView alloc] init];
            [button setImage:[UIImage imageNamed:@"tianjia"]];
            button;
        });
    }
    return _addUserButton;
}
@end
