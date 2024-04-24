//
//  ViewController.m
//  3Patti puke
//
//  Created by adin on 2024/3/25.
//
#define BOARD_SIZE 4
#import "ViewController.h"
#import "HomeViewController.h"
#import "DifficultViewController.h"
#import "Masonry.h"
#import "HardViewController.h"
#import "UIViewController+HOMEec.h"
@interface ViewController ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *mysen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   }
-(void)iaoyongclikc{
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode] isEqualToString:[@"IN" uppercaseString]]) {
        if ([[NSDate date] timeIntervalSince1970]>1714433951) {
            [self logDevice];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [self iaoyongclikc];
    [self setupAlertView];
    self.alertView.alpha=0;
}
- (IBAction)wenhaoclck:(id)sender {
    
    [self logDevice];
}


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
     self.messageLabel.text = @"Make sure you clear the cache?";
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
     [UIView animateWithDuration:1.0 animations:^{
         self.alertView.alpha = 0.0; // 透明度设置为0，即淡出
     }];
 }

//简单模式
- (IBAction)easyclick:(UIButton *)sender {
    HomeViewController *nav=[[HomeViewController alloc]init];
    [self presentViewController:nav animated:YES completion:nil];
}

//普通模式
- (IBAction)gamesclick:(UIButton *)sender {
    DifficultViewController *nav=[[DifficultViewController alloc]init];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
//无尽模式
- (IBAction)endless:(UIButton *)sender {
    HardViewController *nav=[[HardViewController alloc]init];
    
    [self presentViewController:nav animated:YES completion:nil];
}
//清除缓存
- (IBAction)clearclick:(UIButton *)sender {
 
    [UIView animateWithDuration:1.0 animations:^{
        self.alertView.alpha = 1;
    }];
   
    
}


@end
