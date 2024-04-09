//
//  MPBaseNavigationController.m
//  MissPokerGame
//
//  Created by mac on 2024/3/24.
//

#import "MPBaseNavigationController.h"

@interface MPBaseNavigationController ()

@end

@implementation MPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self resizeCustomView];
}

-(void)resizeCustomView
{
    self.navigationBarHidden = YES;
}
#pragma mark ---------- Life Cycle ----------
#pragma mark ---------- API Manager ----------
#pragma mark ---------- Delegate ----------
#pragma mark ---------- Private Method ----------

#pragma mark ---------- Event Response ----------
#pragma mark ---------- Getters and Setters ----------
@end
