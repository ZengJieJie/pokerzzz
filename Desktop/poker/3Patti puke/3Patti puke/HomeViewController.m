//
//  HomeViewController.m
//  3Patti puke
//
//  Created by adin on 2024/4/4.
//
#define BOARD_SIZE 5
#import "imageview.h"
#import "Masonry.h"
#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) NSMutableArray *tileViews;
@property (nonatomic, assign) BOOL gameOver;
@property (weak, nonatomic) IBOutlet UIView *backview;

@property (weak, nonatomic) IBOutlet UILabel *Recordslab;


@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加弹窗
    [self setupAlertView];
    self.alertView.alpha=0;
    [self setupGame];
    // Do any additional setup after loading the view.
}
- (IBAction)Backclick:(UIButton *)sender {
    
    [self setupAlertView];
}

- (void)setupGame {
    self.board = [NSMutableArray array];
    self.tileViews = [NSMutableArray array];
    self.gameOver = NO;
    
    for (int i = 0; i < BOARD_SIZE; i++) {
        NSMutableArray *row = [NSMutableArray array];
        NSMutableArray *rowview = [NSMutableArray array];
        for (int j = 0; j < BOARD_SIZE; j++) {
            [row addObject:@(0)];
          //  [rowview addObject:@(0)];
        }
        [self.board addObject:row];
      //  [self.tileViews addObject:rowview];
    }
    
    [self spawnNumber];
   
    [self updateUI];
}

- (void)spawnNumber {
    for (int i=0; i<2; i++) {
        NSInteger initialNumber = arc4random_uniform(2) == 0 ? 1 : 2; // Generate initial number (2 or 4)
            
            NSMutableArray *emptyCells = [NSMutableArray array];
            for (int i = 0; i < BOARD_SIZE; i++) {
                for (int j = 0; j < BOARD_SIZE; j++) {
                    if ([self.board[i][j] integerValue] == 0) {
                        [emptyCells addObject:[NSValue valueWithCGPoint:CGPointMake(i, j)]];
                    }
                }
            }
            
            if (emptyCells.count > 0) {
                
                NSInteger randomIndex = arc4random_uniform((int)emptyCells.count);
                CGPoint randomPoint = [emptyCells[randomIndex] CGPointValue];
                
                self.board[(int)randomPoint.x][(int)randomPoint.y] = @(initialNumber);
                
            }
        
    }
    
    
}

- (IBAction)leftclikc:(UIButton *)sender {
    [self spawnNumber];
    [self moveLeft];
    [self updateUI];
    
    if([self isGameOver]){
        [self showGameOverAlert];
    }
}
- (IBAction)rightclikc:(id)sender {
    [self spawnNumber];
    [self moveRight];
    [self updateUI];
    if([self isGameOver]){
        [self showGameOverAlert];
    }
}
- (IBAction)upclick:(id)sender {
    [self spawnNumber];
    [self moveUp];
    [self updateUI];
    if([self isGameOver]){
        [self showGameOverAlert];
    }
}
- (IBAction)down:(id)sender {
    
    [self spawnNumber];
    [self moveDown];
    [self updateUI];
    if([self isGameOver]){
        [self showGameOverAlert];
    }
}

- (void)updateUI {
    // Remove all tile views
    for (imageview *tileView in self.tileViews) {
        [tileView removeFromSuperview];
    }
    [self.tileViews removeAllObjects];
    
    // Add tile views for each tile in the board
    CGFloat tilewidth = (self.backview.frame.size.width-60)/BOARD_SIZE;
    CGFloat tileheight=(self.backview.frame.size.width-60)/BOARD_SIZE;
    CGFloat padding = 10;
    NSInteger big=0;
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            NSInteger value = [self.board[i][j] integerValue];
            if(value>big){
                big=value;
            }
            if (value != 0) {
           
                        CGRect frame = CGRectMake((padding + j * (tilewidth + padding)),
                                                  padding + i * (tileheight + padding),
                                                  tilewidth,
                                                  tileheight);
                        imageview *tileView = [[imageview alloc] initWithFrame:frame value:value];
                        [self.backview addSubview:tileView];
                        [self.tileViews addObject:tileView];
                
//                }
             
               
              
            }
        }
    }
    self.Recordslab.text=[NSString stringWithFormat:@"BIG:%ld",(long)big];
}

- (void)moveLeft {
    for (int row = 0; row < BOARD_SIZE; row++) {
         // 合并相邻的相同数字方块
         for (int col = 0; col < BOARD_SIZE - 1; col++) {
             for (int mergeCol = col + 1; mergeCol < BOARD_SIZE; mergeCol++) {
                 if ([self.board[row][mergeCol] integerValue] > 0) {
                     if ([self.board[row][col] integerValue] == 0) {
                         // 如果当前位置为空，移动数字方块到当前位置
                         self.board[row][col] = self.board[row][mergeCol];
                         self.board[row][mergeCol] = @(0);
                         break;
                     } else if ([self.board[row][col] integerValue] == [self.board[row][mergeCol] integerValue]) {
                         // 如果当前位置的数字和相邻位置的数字相同，则合并
                         self.board[row][col] = @([self.board[row][col] integerValue]+1);
                         self.board[row][mergeCol] = @(0);
                         break;
                     } else {
                         break;
                     }
                 }
             }
         }
     }
    
  
        
    // Implement logic to move tiles to the left
}

- (void)moveRight {
    
    for (int row = 0; row < BOARD_SIZE; row++) {
           // 合并相邻的相同数字方块
           for (int col = BOARD_SIZE - 1; col >= 0; col--) {
               for (int mergeCol = col - 1; mergeCol >= 0; mergeCol--) {
                   if ([self.board[row][mergeCol] integerValue] > 0) {
                       if ([self.board[row][col] integerValue] == 0) {
                           // 如果当前位置为空，移动数字方块到当前位置
                           self.board[row][col] = self.board[row][mergeCol];
                           self.board[row][mergeCol] = @(0);
                           break;
                       } else if ([self.board[row][col] integerValue] == [self.board[row][mergeCol] integerValue]) {
                           // 如果当前位置的数字和相邻位置的数字相同，则合并
                           self.board[row][col] = @([self.board[row][col] integerValue]+1);
                           self.board[row][mergeCol] = @(0);
                           break;
                       } else {
                           break;
                       }
                   }
               }
           }
       }
    // Implement logic to move tiles to the right
}

- (void)moveUp {
    for (int col = 0; col < BOARD_SIZE; col++) {
           // 合并相邻的相同数字方块
           for (int row = 0; row < BOARD_SIZE - 1; row++) {
               for (int mergeRow = row + 1; mergeRow < BOARD_SIZE; mergeRow++) {
                   if ([self.board[mergeRow][col] integerValue] > 0) {
                       if ([self.board[row][col] integerValue] == 0) {
                           // 如果当前位置为空，移动数字方块到当前位置
                           self.board[row][col] = self.board[mergeRow][col];
                           self.board[mergeRow][col] = @(0);
                           break;
                       } else if ([self.board[row][col] integerValue] == [self.board[mergeRow][col] integerValue]) {
                           // 如果当前位置的数字和相邻位置的数字相同，则合并
                           self.board[row][col] = @([self.board[row][col] integerValue]+1);
                           self.board[mergeRow][col] = @(0);
                           break;
                       } else {
                           break;
                       }
                   }
               }
           }
       }
    // Implement logic to move tiles up
}

- (void)moveDown {
    
    for (int col = 0; col < BOARD_SIZE; col++) {
            // 合并相邻的相同数字方块
            for (int row = BOARD_SIZE - 1; row >= 0; row--) {
                for (int mergeRow = row - 1; mergeRow >= 0; mergeRow--) {
                    if ([self.board[mergeRow][col] integerValue] > 0) {
                        if ([self.board[row][col] integerValue] == 0) {
                            // 如果当前位置为空，移动数字方块到当前位置
                            self.board[row][col] = self.board[mergeRow][col];
                            self.board[mergeRow][col] = @(0);
                            break;
                        } else if ([self.board[row][col] integerValue] == [self.board[mergeRow][col] integerValue]) {
                            // 如果当前位置的数字和相邻位置的数字相同，则合并
                            self.board[row][col] = @([self.board[row][col] integerValue]+1);
                            self.board[mergeRow][col] = @(0);
                            break;
                        } else {
                            break;
                        }
                    }
                }
            }
        }
    // Implement logic to move tiles down
}

- (BOOL)isGameOver {
    // 遍历整个棋盘
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            // 如果当前位置为空，则游戏尚未结束
            if ([self.board[i][j] integerValue] == 0) {
                return NO;
            }
            // 检查当前位置的数字方块的上、下、左、右四个方向是否有相邻的相同数字方块
            if (i > 0 && [self.board[i][j] integerValue] == [self.board[i - 1][j] integerValue]) {
                return NO;
            }
            if (i < BOARD_SIZE - 1 && [self.board[i][j] integerValue] == [self.board[i + 1][j] integerValue]) {
                return NO;
            }
            if (j > 0 && [self.board[i][j] integerValue] == [self.board[i][j - 1] integerValue]) {
                return NO;
            }
            if (j < BOARD_SIZE - 1 && [self.board[i][j] integerValue] == [self.board[i][j + 1] integerValue]) {
                return NO;
            }
        }
    }
    // 如果遍历完整个棋盘都没有找到可以合并的相邻数字方块，则游戏结束
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupAlertView {
    self.alertView = [[UIView alloc] initWithFrame:CGRectZero];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.layer.cornerRadius = 10;
    self.alertView.layer.masksToBounds = YES;
    [self.view addSubview:self.alertView];
    
    // 添加标题标签
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"Tips";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.alertView addSubview:self.titleLabel];
    
    // 添加消息标签
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.text = @"Confirm exit game？";
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:self.messageLabel];
    
    // 添加取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.cancelButton];
    
    // 添加确定按钮
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.confirmButton setTitle:@"OK" forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:self.confirmButton];
    
    // 设置约束
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@(300)); // 设置弹窗宽度
        make.height.equalTo(@(150)); // 设置弹窗高度
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alertView);
        make.top.equalTo(self.alertView).offset(20);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alertView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.alertView).offset(20);
        make.right.equalTo(self.alertView).offset(-20);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertView).offset(20);
        make.bottom.equalTo(self.alertView).offset(-20);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.right.equalTo(self.confirmButton.mas_left).offset(-20);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.alertView).offset(-20);
        make.bottom.equalTo(self.alertView).offset(-20);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
}

- (void)cancelButtonTapped {
    
        [UIView animateWithDuration:1.0 animations:^{
            self.alertView.alpha = 0.0; // 透明度设置为0，即淡出
        }];
}

- (void)confirmButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [UIView animateWithDuration:1.0 animations:^{
//        self.alertView.alpha = 0.0; // 透明度设置为0，即淡出
//    }];
}


- (void)showGameOverAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Game over" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupGame];
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
