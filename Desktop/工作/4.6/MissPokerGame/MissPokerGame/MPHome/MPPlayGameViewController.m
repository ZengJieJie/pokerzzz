//
//  MPPlayGameViewController.m
//  MissPokerGame
//
//  Created by mac on 2024/4/2.
//

#import "MPPlayGameViewController.h"
#import "MPCardView.h"
#import "MPUserInfoModel.h"
#import "MPCacheManager.h"
#import "MPAlertView.h"
#import "MPPokerCardModel.h"
#import "MPCardInfoView.h"

@interface MPPlayGameViewController ()

@property (nonatomic ,strong)UIImageView *topBgImageView;
@property (nonatomic ,strong)UIImageView *bgImageView;

@property (nonatomic ,strong)UILabel *userNameLabel;
@property (nonatomic ,strong)UIImageView *cardBgView;
@property (nonatomic ,strong)NSMutableArray<MPUserInfoModel *> *userNameList;
@property (nonatomic ,strong)NSMutableArray<MPPokerCardModel *> *cardInfoList;
@property (nonatomic ,assign)NSInteger pokerIndex;
@property (nonatomic ,strong)UILabel *cardNumberLabel;

@property (nonatomic ,assign)NSInteger cardMaxCount;
@property (nonatomic ,strong)UIView *cardLeftView;
@property (nonatomic ,strong)MPCardView *cardView;
@property (nonatomic ,strong)MPCardInfoView *cardInfoView;

@end

@implementation MPPlayGameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pokerIndex = 0;
    self.cardMaxCount = self.cardInfoList.count;
    [self resizeCustomView];
    
    //启用设备旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

}
#pragma mark 调整自定义视图
-(void)resizeCustomView
{
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.topBgImageView];
    [self.bgImageView addSubview:self.cardLeftView];
    [self.bgImageView addSubview:self.cardBgView];
    [self.bgImageView addSubview:self.cardInfoView];
    [self.cardLeftView addSubview:self.userNameLabel];
    [self.cardLeftView addSubview:self.cardNumberLabel];
    [self.view sendSubviewToBack:self.cardBgView];
    [self.view bringSubviewToFront:self.backButton];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left).offset(0);
        make.top.equalTo(self.bgImageView.mas_top).offset(0);
        make.right.equalTo(self.bgImageView.mas_right).offset(0);
        make.height.mas_equalTo(100);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardLeftView.mas_centerY).offset(0);
        make.left.equalTo(self.cardLeftView.mas_left).offset(10);
        make.right.equalTo(self.cardLeftView.mas_right).offset(-10);
    }];
    
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cardLeftView.mas_centerX).offset(0);
        make.bottom.equalTo(self.cardLeftView.mas_bottom).offset(-10);
    }];
    [self reSizeUI];
    [self refreshPlayUI];
}
- (void)reSizeUI {
    CGFloat biLiX = self.view.width/852.0;
    CGFloat biLiY = self.view.height/393.0;
    
    CGFloat spacLeft = 65 * biLiX;
    CGFloat centerSpac = 45 * biLiX;
    CGFloat spacTop = 113  * biLiY;
    CGFloat itemWidth = (self.view.width - (spacLeft * 2) - (centerSpac * 2))/3.0;
    CGFloat itemHeight = self.view.height-spacTop - 45*biLiY;
    
    [self.cardLeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImageView.mas_left).offset(spacLeft);
        make.top.equalTo(self.bgImageView.mas_top).offset(spacTop);
        make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
    }];
    
    CGFloat width  = self.view.width > self.view.height? self.view.height : self.view.width;
    width = width - 170;
    [self.cardBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardLeftView.mas_right).offset(centerSpac);
        make.top.equalTo(self.bgImageView.mas_top).offset(spacTop);
        make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
    }];
    
    [self.cardInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageView.mas_right).offset(-spacLeft);
        make.top.equalTo(self.bgImageView.mas_top).offset(spacTop);
        make.size.mas_equalTo(CGSizeMake(itemWidth, itemHeight));
    }];
    [self.cardView refreshUI];
    [self.view layoutIfNeeded];
}
#pragma mark ---------- Life Cycle ----------
#pragma mark ---------- API Manager ----------
#pragma mark ---------- Delegate ----------
- (void)orientationChanged:(NSNotification *)noti {
    [self reSizeUI];
}

#pragma mark ---------- Private Method ----------
-(BOOL)isLandscape {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}
-(void)refreshPlayUI{
    MPUserInfoModel *user = self.userNameList[self.pokerIndex % self.userNameList.count];
    BOOL  isOneStyle = self.pokerIndex % 2 == 0;
    self.userNameLabel.text = [NSString stringWithFormat:@"User Name:%@",user.userName];
    self.cardNumberLabel.text = [NSString stringWithFormat:@"%ld pieces",self.cardMaxCount - self.pokerIndex];
    self.cardNumberLabel.textColor = self.titleLabel.textColor = [UIColor colorWithHexString:isOneStyle?@"#ffffff":@"#ffffff"];
}
- (void)showCard {
    CGFloat topHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44;
    MPCardView *cardView = [[MPCardView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.width, self.view.height - topHeight)];
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(topHeight, 0, 0, 0));
    }];
    [cardView showCard:self.cardInfoList[self.pokerIndex]];
    [self.cardInfoView updateCardInfo:self.cardInfoList[self.pokerIndex]];
    self.cardView = cardView;
    
    [cardView.closeButton addTarget:self action:@selector(closeButtonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark ---------- Event Response ----------
- (void)closeButtonButtonClick:(UIButton*)sender {
    [sender.superview removeFromSuperview];
    self.pokerIndex ++;
    [self refreshPlayUI];
    
    if (self.pokerIndex >= self.cardMaxCount) {
        MPAlertView *alertView = [[MPAlertView alloc] initWithTitle:@"Restart Game" confirmTitle:@"OK" cancelTitle:@"NO"];
        alertView.cancelAction = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        alertView.closeAction = ^{
            self.pokerIndex =0;
            [self refreshPlayUI];
        };
        alertView.confirmAction = ^{
            self.pokerIndex =0;
            [self refreshPlayUI];
        };
        [alertView show];
    }
}
- (void)flipCard:(UITapGestureRecognizer *)gesture {
    [self refreshPlayUI];
    [self showCard];
}
#pragma mark ---------- Getters and Setters ----------

-(UIImageView *)topBgImageView
{
    if (!_topBgImageView) {
        _topBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topImage"]];
    }
    return _topBgImageView;
}
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardbg"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

-(UIView *)cardLeftView
{
    if (!_cardLeftView) {
        _cardLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _cardLeftView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    }
    return _cardLeftView;
}
-(UIImageView *)cardBgView {
    if (!_cardBgView) {
        _cardBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _cardBgView.userInteractionEnabled = YES;
        _cardBgView.image = [UIImage imageNamed:@"pg_cardBg"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard:)];
        [_cardBgView addGestureRecognizer:tapGesture];
    }
    return _cardBgView;
}
-(MPCardInfoView *)cardInfoView
{
    if (!_cardInfoView) {
        _cardInfoView = [[MPCardInfoView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _cardInfoView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    }
    return _cardInfoView;
}

-(UILabel *)userNameLabel
{
    if(!_userNameLabel){
        _userNameLabel = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.numberOfLines = 0;
            lable.textColor = UIColor.whiteColor;
            lable;
        });
    }
    return _userNameLabel;
}
-(UILabel *)cardNumberLabel
{
    if(!_cardNumberLabel){
        _cardNumberLabel = ({
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            lable.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            lable.textAlignment = NSTextAlignmentLeft;
            lable;
        });
    }
    return _cardNumberLabel;
}
-(NSMutableArray<MPUserInfoModel *> *)userNameList
{
    if (!_userNameList) {
        _userNameList = [NSMutableArray new];
        if (MPCacheManager.userList.count) {
            [_userNameList addObjectsFromArray:MPCacheManager.userList];
        }
    }
    return _userNameList;
}
-(NSMutableArray<MPPokerCardModel *> *)cardInfoList
{
    if (!_cardInfoList) {
        _cardInfoList = [NSMutableArray new];
        NSArray *array = [MPPokerCardModel sortedRandomArrayByArray:[MPPokerCardModel defaultCardList]];
        if (array.count) {
            [_cardInfoList addObjectsFromArray:array];
        }
    }
    return _cardInfoList;
}

@end
