//
//  MPHomeViewController.m
//  MissPokerGame
//
//  Created by mac on 2024/3/24.
//

#import "MPHomeViewController.h"
#import "MPUserInfoCell.h"
#import "MPUserInfoDefaultCell.h"
#import "MPUserInfoModel.h"
#import "MPCacheManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MPPlayGameViewController.h"
#import "MPAlertView.h"

@interface MPHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray<MPUserInfoModel *> *userNameList;
@property (nonatomic ,strong)UITableView *playUserListTab;
@property (nonatomic ,strong)UIButton *nextStepButton;
@end

@implementation MPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"Add Player";
    [self resizeCustomView];
}

-(void)resizeCustomView
{
    [self.view addSubview:self.playUserListTab];
    [self.view addSubview:self.nextStepButton];
    
    [self.playUserListTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake([UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44 + 10, 0, 90, 0));
    }];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.top.equalTo(self.playUserListTab.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(60);
    }];
}
#pragma mark ---------- Life Cycle ----------
#pragma mark ---------- API Manager ----------
#pragma mark ---------- Delegate ----------
#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.userNameList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPUserInfoModel *userInfo = self.userNameList[indexPath.section];
    if (userInfo.isAddUserButton == NO) {
        BOOL  isOneStyle = indexPath.section % 2 == 0;
        NSString *cellIdentifier = @"MPUserInfoCell";
        MPUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[MPUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeUserCell:)];
            [cell.removeUserButton addGestureRecognizer:tapges];
        }
        [cell updateThemeColor:[UIColor colorWithHexString:isOneStyle?@"#3a29f3":@"#F329E2"]];
        [cell updateUserInfoModel:userInfo];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.removeUserButton.tag = indexPath.section;
        return cell;
    } else {
        NSString *cellIdentifier = @"MPUserInfoDefaultCell";
        MPUserInfoDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[MPUserInfoDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.userNameList.count-1 <= indexPath.section) {
        AudioServicesPlaySystemSound(1519);
        self.playUserListTab.userInteractionEnabled = NO;
        NSInteger insrtIndex = self.userNameList.count-1;
        [self.userNameList insertObject:[MPUserInfoModel new] atIndex:insrtIndex];
        
        [self.playUserListTab performBatchUpdates:^{
            [self.playUserListTab insertSection:insrtIndex withRowAnimation:UITableViewRowAnimationAutomatic];
        } completion:^(BOOL finished) {
            [self.playUserListTab reloadData];
            self.playUserListTab.userInteractionEnabled = YES;
        }];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *setionHeaderView = [UIView new];
    return setionHeaderView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *setionFooterView = [UIView new];
    return setionFooterView;
}
#pragma mark ---------- Private Method ----------
- (void)userNoNullAlertWithUserNameNull:(BOOL)isNameNull {
    
    MPAlertView *alertView = [[MPAlertView alloc] initWithTitle:isNameNull?@"The user name cannot be empty ！":@"Please add a gamer !" confirmTitle:@"OK" cancelTitle:@""];
    alertView.cancelAction = ^{
 
    };
    alertView.closeAction = ^{

    };
    alertView.confirmAction = ^{

    };
    [alertView show];
}
#pragma mark ---------- Event Response ----------
- (void)removeUserCell:(UITapGestureRecognizer *)sender {
    AudioServicesPlaySystemSound(1519);
    self.playUserListTab.userInteractionEnabled = NO;
    [self.userNameList removeObjectAtIndex:sender.view.tag];
    [self.playUserListTab reloadData];
    self.playUserListTab.userInteractionEnabled = YES;
}
- (void)nextStepButtonClick {
    if (self.userNameList.count < 2) {
        [self userNoNullAlertWithUserNameNull:NO];
        return;
    }
    for (MPUserInfoModel *user in self.userNameList) {
        if (user.userName.length < 1 && user.isAddUserButton == NO) {
            [self userNoNullAlertWithUserNameNull:YES];
            return;
        }
    }
    
    AudioServicesPlaySystemSound(1519);
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.userNameList];
    [array removeLastObject];
    [MPCacheManager cacheUserList:array];
    
    
    [self.navigationController pushViewController:[[MPPlayGameViewController alloc] init] animated:YES];
}
#pragma mark ---------- Getters and Setters ----------

-(NSMutableArray<MPUserInfoModel *> *)userNameList
{
    if (!_userNameList) {
        _userNameList = [NSMutableArray new];
        if (MPCacheManager.userList.count) {
            [_userNameList addObjectsFromArray:MPCacheManager.userList];
        }
        [_userNameList addObject:[MPUserInfoModel createAddUserModel]];
    }
    return _userNameList;
}

- (UITableView *)playUserListTab
{
    if (!_playUserListTab)
    {
        _playUserListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        [_playUserListTab setDelegate:self];
        [_playUserListTab setDataSource:self];
        [_playUserListTab setSeparatorInset:UIEdgeInsetsZero];
        _playUserListTab.separatorColor = UIColor.clearColor;
        _playUserListTab.estimatedRowHeight = 44.0f;
        _playUserListTab.rowHeight =UITableViewAutomaticDimension;
        _playUserListTab.showsHorizontalScrollIndicator = NO;
        _playUserListTab.showsVerticalScrollIndicator = NO;
        _playUserListTab.backgroundColor = UIColor.clearColor;
        _playUserListTab.clipsToBounds = YES;
    }
    
    return _playUserListTab;
}

-(UIButton *)nextStepButton
{
    if(!_nextStepButton){
        _nextStepButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [button setTitle:@"Play Game" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
            button.backgroundColor = UIColor.whiteColor;
            button.layer.cornerRadius = 30.f;
            button;
        });
        [_nextStepButton addTarget:self action:@selector(nextStepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}
@end
