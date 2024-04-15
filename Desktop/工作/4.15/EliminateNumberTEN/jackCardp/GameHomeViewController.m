//
//  GameHomeViewController.m
//  jackCardp
//
//  Created by qweqeqwe on 2024/4/13.
//

#import "GameHomeViewController.h"
#import "GameBoard.h"
#import "EliminationRule.h"
#import "MBProgressHUD.h"
#import "CustomAlertView.h"
#import "HistoryItem.h"
@interface GameHomeViewController ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *board; // 游戏面板
@property (nonatomic, assign) NSUInteger rows; // 行数
@property (nonatomic, assign) NSUInteger columns; // 列数
@property (nonatomic, assign) NSUInteger score; // 得分
@property (nonatomic, assign) UIView* gridContainer; // 得分
@property (nonatomic, assign) UILabel* scoreLabel; // 得分
@property (nonatomic, assign) UILabel* countdownLabel; // 得分
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger secondsRemaining;

@end

@implementation GameHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _score = 0;
    
    
    // 设置背景图
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"displayGameInterface"]; // 替换为你的背景图名称
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    

    //开始游戏
    GameBoard *gameBoard = [[GameBoard alloc] initWithRows:5 columns:5];
    // 初始化游戏面板
    [gameBoard initializeBoard];

    

    self.board = gameBoard.board;
    
    // 打印游戏面板
    [self printBoard];

    //显示面板
    [self displayGameInterface];
    
    // 开始倒计时
      self.secondsRemaining = 60;
      [self updateCountdownLabel];
      self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(timerTick)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

- (void)timerTick {
    if (self.secondsRemaining > 0) {
        self.secondsRemaining--;
        [self updateCountdownLabel];
    } else {
        [self.timer invalidate];
        NSLog(@"Time's up!");
        // 在这里添加你的提示代码
        
        
        //保存历史记录
        // 创建一个HistoryItem对象
        HistoryItem *item = [[HistoryItem alloc] init];
        item.date = [NSDate date]; // 当前日期和时间
        item.score = self.score; // 当前得分

        // 将HistoryItem对象转换为NSDictionary
        NSDictionary *itemDict = @{@"Date": item.date, @"Score": @(item.score)};

        // 从UserDefaults中获取现有的历史记录数组
        NSMutableArray *historyItems = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryItems"] mutableCopy];

        if (!historyItems) {
            // 如果没有历史记录数组，则创建一个新的空数组
            historyItems = [NSMutableArray array];
        }

        // 将新的历史记录项添加到数组中
        [historyItems addObject:itemDict];

        // 将更新后的历史记录数组保存回UserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:historyItems forKey:@"HistoryItems"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game over" message:[NSString stringWithFormat:@"Time's up! your score is :%ld", (long)self.score] preferredStyle:UIAlertControllerStyleAlert];
            
            // 创建"再来一句"按钮
            UIAlertAction *againAction = [UIAlertAction actionWithTitle:@"Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 处理"再来一句"按钮点击事件
                NSLog(@"再来一句");
                
                //开始游戏
                GameBoard *gameBoard = [[GameBoard alloc] initWithRows:5 columns:5];
                // 初始化游戏面板
                [gameBoard initializeBoard];

                

                self.board = gameBoard.board;
                [self reloadGridImages];
                
                self->_score = 0;
                self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", _score];
                // 开始倒计时
                self.secondsRemaining = 60;
                  [self updateCountdownLabel];
                  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                target:self
                                                              selector:@selector(timerTick)
                                                              userInfo:nil
                                                               repeats:YES];
                
            }];
          [againAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];  forKey:@"titleTextColor"; // 设置按钮文字颜色为半透明黑色
           
            [againAction setValue:@(YES) forKey:@"enabled"]; // 让按钮可点击
            [alertController addAction:againAction];
            
            // 创建"返回"按钮
            UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 处理"返回"按钮点击事件
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
        [returnAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];  // 设置按钮文字颜色为半透明黑色
          
            [returnAction setValue:@(YES) forKey:@"enabled"]; // 让按钮可点击
            [alertController addAction:returnAction];
            
            // 显示提示框
            [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        

    }
}

- (void)updateCountdownLabel {
    
    
    self.countdownLabel.text = [NSString stringWithFormat:@"Time:%ld", (long)self.secondsRemaining];
}

// 显示游戏面板
- (void)displayGameInterface {
    // 屏幕宽度
        CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
        
        // 左边板块占据整个横向屏幕的60%宽度，距离屏幕左边留出20像素
        CGFloat leftBlockWidth = screenWidth * 0.45;
        CGFloat leftBlockX = 80;
        
        // 左边板块的容器视图
        UIView *leftBlock = [[UIView alloc] initWithFrame:CGRectMake(leftBlockX, CGRectGetHeight(self.view.bounds) * 0.1, leftBlockWidth, CGRectGetHeight(self.view.bounds) * 0.8)];
//        leftBlock.backgroundColor = [UIColor lightGrayColor]; // 左边板块的背景颜色
        [self.view addSubview:leftBlock];
        
        // 添加方格按钮阵列
        [self addGridViewToView:leftBlock];
       
        
        // 右边板块占据整个横向屏幕的30%宽度，距离屏幕右边留出20像素
        CGFloat rightBlockWidth = screenWidth * 0.3;
        CGFloat rightBlockX = screenWidth - rightBlockWidth - 80;
        
        // 右边板块的容器视图
        UIView *rightBlock = [[UIView alloc] initWithFrame:CGRectMake(rightBlockX, CGRectGetHeight(self.view.bounds) * 0.1, rightBlockWidth, CGRectGetHeight(self.view.bounds) * 0.9)];
//        rightBlock.backgroundColor = [UIColor lightGrayColor]; // 右边板块的背景颜色
        [self.view addSubview:rightBlock];
        
        // 添加分数和倒计时文字显示
        [self addScoreAndCountdownLabelsToView:rightBlock];
}



// 在左边板块中添加方格按钮阵列
- (void)addGridViewToView:(UIView *)view {
    // 方格按钮阵列的容器视图
    UIView *gridContainer = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:gridContainer];
    self.gridContainer = gridContainer; // 保存按钮阵列的容器视图
    
    // 在容器视图中创建5列5行的方格按钮
    CGFloat buttonWidth = (CGRectGetWidth(gridContainer.bounds) - 4 * 5) / 5;
    CGFloat buttonHeight = (CGRectGetHeight(gridContainer.bounds) - 4 * 5) / 5;
    
    for (int row = 0; row < 5; row++) {
        for (int col = 0; col < 5; col++) {
            // 计算按钮的位置
            CGFloat buttonX = col * (buttonWidth + 5);
            CGFloat buttonY = row * (buttonHeight + 5);
            
            // 创建按钮并设置位置
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
            
            NSString *numberimgString = [NSString stringWithFormat:@"%@",self.board[row][col] ];
            
            [button setBackgroundImage:[UIImage imageNamed:numberimgString] forState:UIControlStateNormal]; // 设置按钮的背景图片
            [button setTitle:@"" forState:UIControlStateNormal]; // 清空按钮标题
            button.tag = row * 5 + col + 1; // 设置按钮的tag值，用于标识按钮在阵列中的位置
            [button addTarget:self action:@selector(buttonTapped2:) forControlEvents:UIControlEventTouchUpInside]; // 添加按钮点击事件
            [gridContainer addSubview:button];
        }
    }
}

- (void)eliminateNumbersWithSelectedNumber:(NSNumber *)selectedNumber {
    
   
    
    // 遍历游戏面板，消除与选定数字相加等于10的其他数字单元
    NSMutableArray *rowsToRemove = [NSMutableArray array];
    for (NSUInteger row = 0; row < self.board.count; row++) {
        NSMutableArray<NSNumber *> *currentRow = self.board[row];
        NSMutableArray *indexesToRemove = [NSMutableArray array];
        for (NSUInteger col = 0; col < currentRow.count; col++) {
            NSNumber *currentNumber = currentRow[col];
            if (
                [currentNumber unsignedIntegerValue] + [selectedNumber unsignedIntegerValue] == 10) {
                [indexesToRemove addObject:@(col)];
                self.score++; // 消除得分加1
            }
        }
        if (indexesToRemove.count > 0) {
            [rowsToRemove addObject:@(row)];
//            for (NSNumber *index in indexesToRemove) {
//                [currentRow removeObjectAtIndex:[index unsignedIntegerValue]];
//            }
        }
    }
    
    // 移除符合消除条件的行
    if (rowsToRemove.count > 0) {
        for (NSNumber *index in [rowsToRemove reverseObjectEnumerator]) {
            [self.board removeObjectAtIndex:[index unsignedIntegerValue]];
        }
    }
 
    
    NSLog(@"删除后的当前面板");
//    [self printBoard];
    // 添加新的数字单元
    
   
        for (NSUInteger row = 0; row < rowsToRemove.count; row++) {
            NSMutableArray<NSNumber *> *newRow = [NSMutableArray array];
            for (NSUInteger i = 0; i < 5; i++) {
                NSNumber *number = [NSNumber numberWithUnsignedInteger:(arc4random_uniform(9) + 1)];
                [newRow addObject:number];
            }
//            
//            if(self.board.count > 0){
                NSLog(@"删除后的当前面板1");
                [self.board insertObject:newRow atIndex:0];
//            }else{
//                NSLog(@"删除后的当前面板2");
//                [self.board addObject:newRow];
//            }
            
        }
  
    
    

    
    NSLog(@"添加后的当前面板");
//    [self printBoard];
    // 刷新面板
    [self reloadGridImages];
    
//    NSLog(@"消除与数字 %@ 相加等于10的其他数字单元", selectedNumber);
////    NSLog(@"当前面板：%@", self.board);
//    NSLog(@"当前得分：%lu", (unsigned long)self.score);
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", _score];
}



// 刷新面板
// 重新加载阵列中的图片
- (void)reloadGridImages {
    

    
    // 遍历阵列中的按钮，为每个按钮设置新的图片
    for (UIView *subview in self.gridContainer.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                // 获取按钮的行和列
                NSInteger row = (button.frame.origin.y / button.frame.size.height);
                NSInteger col = (button.frame.origin.x / button.frame.size.width);
                
                // 获取对应位置的图片名称
                // 获取对应位置的图片名称
                NSString *imageName = [NSString stringWithFormat:@"%@",self.board[row][col]];
                
                // 设置按钮的新图片
                // 设置动画效果
                        [UIView transitionWithView:button
                                          duration:0.5
                                           options:UIViewAnimationOptionTransitionFlipFromLeft
                                        animations:^{
                            // 在动画中更新按钮的图片
                            [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                        } completion:^(BOOL finished) {
                            // 动画完成后，启用用户交互
                            self.view.userInteractionEnabled = YES;
                        }];
            }
        }
    
}

// 在右边板块中添加分数和倒计时文字显示
- (void)addScoreAndCountdownLabelsToView:(UIView *)view {
    // 分数标签
    // 分数标签
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.bounds) * 0.2, CGRectGetWidth(view.bounds), 50)];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.text = @"Score: 0";
    scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    scoreLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    scoreLabel.layer.cornerRadius = 10; // 设置圆角
     scoreLabel.layer.masksToBounds = YES; // 遮罩多余部分
    
    // 保持背景图宽高比，填充整个UILabel
    scoreLabel.contentMode = UIViewContentModeScaleAspectFill;
    scoreLabel.clipsToBounds = YES;
    [view addSubview:scoreLabel];
    self.scoreLabel = scoreLabel; // 保存分数标签
    
    // 倒计时标签
    UILabel *countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scoreLabel.frame) + 20, CGRectGetWidth(view.bounds), 50)];
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.textColor = [UIColor whiteColor];
    countdownLabel.text = @"Time: 60";
    countdownLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    countdownLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    countdownLabel.layer.cornerRadius = 10; // 设置圆角
    countdownLabel.layer.masksToBounds = YES; // 遮罩多余部分
    // 保持背景图宽高比，填充整个UILabel
    countdownLabel.contentMode = UIViewContentModeScaleAspectFill;
    countdownLabel.clipsToBounds = YES;
    self.countdownLabel = countdownLabel;
    [view addSubview:countdownLabel];
    
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, CGRectGetMaxY(countdownLabel.frame) + 20, CGRectGetWidth(view.bounds), 40);
    [backButton setTitle:@"Return" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_background"] forState:UIControlStateNormal];
    backButton.layer.cornerRadius = 10; // 设置圆角
     backButton.layer.masksToBounds = YES; // 遮罩多余部分
    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
}

// 返回按钮点击事件
- (void)backButtonTapped:(UIButton *)sender {
    // 在这里处理返回按钮点击事件
    [self dismissViewControllerAnimated:NO completion:nil];
}

// 按钮点击事件
- (void)buttonTapped2:(UIButton *)sender {
    // 禁用用户交互
    self.view.userInteractionEnabled = NO;
    // 计算按钮在阵列中的行列号
    NSInteger row = (sender.tag - 1) / 5;
    NSInteger col = (sender.tag - 1) % 5;
    
    
    NSLog(@"------------");
    NSLog(@"按钮在第 %ld 行第 %ld 列", (long)row, (long)col);
    NSLog(@"按钮%@", self.board[row][col]);
    [self eliminateNumbersWithSelectedNumber:self.board[row][col]];  //选定数字为 5
//    [self eliminateNumbersWithSelectedNumber:@5]; // 选定数字为 5
    

}




- (instancetype)initWithRows:(NSUInteger)rows columns:(NSUInteger)columns {
    self = [super init];
    if (self) {
        _rows = rows;
        _columns = columns;
        _board = [NSMutableArray arrayWithCapacity:rows];
    }
    return self;
}

- (void)initializeBoard {
    for (NSUInteger i = 0; i < self.rows; i++) {
        NSMutableArray<NSNumber *> *row = [NSMutableArray arrayWithCapacity:self.columns];
        for (NSUInteger j = 0; j < self.columns; j++) {
            // 随机生成1到9之间的数字作为初始值
            NSNumber *number = [NSNumber numberWithUnsignedInteger:(arc4random_uniform(9) + 1)];
            [row addObject:number];
        }
        [self.board addObject:row];
    }
}

- (void)printBoard {
    for (NSMutableArray<NSNumber *> *row in self.board) {
        NSMutableString *rowString = [NSMutableString string];
        for (NSNumber *number in row) {
            [rowString appendFormat:@"%@ ", number];
        }
        NSLog(@"%@", rowString);
    }
}


@end


