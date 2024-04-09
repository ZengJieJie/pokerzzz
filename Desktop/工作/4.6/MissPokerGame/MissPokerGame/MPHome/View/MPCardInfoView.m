//
//  MPCardInfoView.m
//  MissPokerGame
//
//  Created by mac on 2024/4/5.
//

#import "MPCardInfoView.h"

@interface MPCardInfoView()
@property (nonatomic ,strong)UILabel *cardNameLabel;
@property (nonatomic ,strong)UILabel *cardDescLabel;
@end
@implementation MPCardInfoView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self resizeCustomView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self resizeCustomView];
    }
    return self;
}

- (void)updateCardInfo:(MPPokerCardModel*)cardInfo {
    self.cardNameLabel.text = cardInfo.cardName;
    self.cardDescLabel.text = cardInfo.cardRule;
}

#pragma mark 调整自定义视图
-(void)resizeCustomView
{
    [self addSubview:self.cardNameLabel];
    [self addSubview:self.cardDescLabel];
    [self.cardDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [self.cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(self.cardDescLabel.mas_top).offset(-15);
    }];
}

-(UILabel *)cardNameLabel
{
    if(!_cardNameLabel){
        _cardNameLabel = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
            lable.textColor = UIColor.whiteColor;
            lable.textAlignment = NSTextAlignmentLeft;
            lable;
        });
    }
    return _cardNameLabel;
}

-(UILabel *)cardDescLabel
{
    if(!_cardDescLabel){
        _cardDescLabel = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lable.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            lable.textColor = UIColor.whiteColor;
            lable.textAlignment = NSTextAlignmentCenter;
            lable.numberOfLines = 0;
            lable;
        });
    }
    return _cardDescLabel;
}
@end
