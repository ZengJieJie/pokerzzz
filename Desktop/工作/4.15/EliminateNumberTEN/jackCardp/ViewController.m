//
//  ViewController.m
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/12.
//

#import "ViewController.h"
#import "GameHomeViewController.h"
#import "introViewController.h"
#import "HistoryViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加背景图
     UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
     backgroundImageView.image = [UIImage imageNamed:@"background_image"];
     [self.view addSubview:backgroundImageView];
     
     CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
     CGFloat screenHeight = CGRectGetHeight(self.view.bounds);
     
     // 游戏图标
     CGFloat gameIconWidth = screenWidth * 0.4;
     CGFloat gameIconHeight = screenHeight * 0.4;
     CGFloat gameIconX = (screenWidth - gameIconWidth) / 2;
     CGFloat gameIconY = (screenHeight * 0.1);
     UIImageView *gameIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gameIconX, gameIconY, gameIconWidth, gameIconHeight)];
     gameIconImageView.image = [UIImage imageNamed:@"game_icon"];
     gameIconImageView.contentMode = UIViewContentModeScaleAspectFit; // 保持宽高比
     [self.view addSubview:gameIconImageView];
     
    // 开始游戏按钮
        CGFloat startButtonWidth = screenWidth * 0.4;
        CGFloat startButtonHeight = screenHeight * 0.2;
        CGFloat startButtonX = (screenWidth - startButtonWidth) / 2;
        CGFloat startButtonY = CGRectGetMaxY(gameIconImageView.frame) + 20;
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        startButton.frame = CGRectMake(startButtonX, startButtonY, startButtonWidth, startButtonHeight);
        startButton.layer.cornerRadius = 10;
        startButton.clipsToBounds = YES;
        [startButton setBackgroundImage:[UIImage imageNamed:@"start_button_background"] forState:UIControlStateNormal];
        [startButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startButton];
     
     // 介绍按钮
     CGFloat introButtonWidth = screenWidth * 0.25;
     CGFloat introButtonHeight = screenHeight * 0.1;
     CGFloat introButtonX = screenWidth * 0.05;
     CGFloat introButtonY = screenHeight * 0.8;
     UIButton *introButton = [UIButton buttonWithType:UIButtonTypeCustom];
     introButton.frame = CGRectMake(introButtonX, introButtonY, introButtonWidth, introButtonHeight);
     introButton.layer.cornerRadius = 10;
     introButton.clipsToBounds = YES;
     [introButton setBackgroundImage:[UIImage imageNamed:@"intro_button_background"] forState:UIControlStateNormal];
     [introButton setTitle:@"Introduction" forState:UIControlStateNormal];
     [introButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [introButton addTarget:self action:@selector(introButtonTapped) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:introButton];
     
     // 历史记录按钮
     CGFloat historyButtonX = screenWidth * 0.7;
     UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
     historyButton.frame = CGRectMake(historyButtonX, introButtonY, introButtonWidth, introButtonHeight);
     historyButton.layer.cornerRadius = 10;
     historyButton.clipsToBounds = YES;
     [historyButton setBackgroundImage:[UIImage imageNamed:@"history_button_background"] forState:UIControlStateNormal];
     [historyButton setTitle:@"History" forState:UIControlStateNormal];
     [historyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [historyButton addTarget:self action:@selector(historyButtonTapped) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:historyButton];

}


- (void)startButtonTapped {
    NSLog(@"Start button tapped");
    // 在这里处理开始游戏按钮的点击事件
    GameHomeViewController *secondViewController = [[GameHomeViewController alloc] init];
    secondViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:secondViewController animated:YES completion:nil];
}

- (void)introButtonTapped {
    NSLog(@"Intro button tapped");
    // 在这里处理介绍按钮的点击事件
    introViewController *intoViewController = [[introViewController alloc] init];
    intoViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:intoViewController animated:YES completion:nil];
    
}

- (void)historyButtonTapped {
    NSLog(@"History button tapped");
    // 在这里处理历史记录按钮的点击事件
    HistoryViewController *toryViewController = [[HistoryViewController alloc] init];
    toryViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:toryViewController animated:YES completion:nil];
    
}



// 开始游戏
- (void)startGame {
    // 创建要跳转的视图控制器
    GameHomeViewController *gameHomeViewController = [[GameHomeViewController alloc] init];
    gameHomeViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:gameHomeViewController animated:YES completion:nil];
}




@end
