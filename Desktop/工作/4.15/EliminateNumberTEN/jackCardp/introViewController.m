//
//  introViewController.m
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/14.
//

#import "introViewController.h"

@interface introViewController ()

@end

@implementation introViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
     // Do any additional setup after loading the view.
     
     // 背景图片
     UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
     backgroundImageView.image = [UIImage imageNamed:@"background_image"];
     backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
     [self.view addSubview:backgroundImageView];
     
     // 返回按钮
     UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [backButton setBackgroundImage:[UIImage imageNamed:@"backButtonImage"] forState:UIControlStateNormal];
     [backButton setTitle:@"Back" forState:UIControlStateNormal];
     [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     backButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
     [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
     backButton.frame = CGRectMake(20, 50, 80, 40);
     [self.view addSubview:backButton];
     
    
    // UIView包含标题和内容
        CGFloat contentViewWidth = CGRectGetWidth(self.view.bounds) - 120; // 调整宽度
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(60, 100, contentViewWidth, CGRectGetHeight(self.view.bounds) - 200)];
        contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5]; // 半透明黑色背景
        contentView.layer.cornerRadius = 20;
        contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        contentView.layer.shadowOffset = CGSizeMake(0, 2);
        contentView.layer.shadowOpacity = 0.5;
        contentView.layer.shadowRadius = 3.0;
        [self.view addSubview:contentView];
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, contentViewWidth - 40, 30)];
        titleLabel.text = @"Game Rules";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:24];
        titleLabel.textColor = [UIColor whiteColor]; // 白色文字
        [contentView addSubview:titleLabel];
        
        // 内容
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 20, contentViewWidth - 40, 100)];
        contentLabel.text = @"Eliminate Number Ten, a casual puzzle game, players aim to clear pairs of numbers on the game board that sum up to 10 within a limited time frame, earning points for each successful elimination and striving to achieve higher scores.";
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.font = [UIFont systemFontOfSize:18];
        contentLabel.textColor = [UIColor whiteColor]; // 白色文字
        [contentView addSubview:contentLabel];
    
    
     
}


- (void)backButtonTapped {
    // Handle back button tap event
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
