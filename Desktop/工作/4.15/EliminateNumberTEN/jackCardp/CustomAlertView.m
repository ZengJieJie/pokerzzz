#import "CustomAlertView.h"

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 创建UILabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 30)];
        titleLabel.text = @"Your score is 100";
        [self addSubview:titleLabel];
        
        // 创建按钮
        UIButton *againButton = [UIButton buttonWithType:UIButtonTypeCustom];
        againButton.frame = CGRectMake(20, 70, 100, 40);
        [againButton setTitle:@"Again" forState:UIControlStateNormal];
        [againButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [againButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]]; // 设置按钮半透明背景色
        againButton.layer.cornerRadius = 10; // 设置按钮圆角
        [againButton addTarget:self action:@selector(againButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:againButton];
        
        UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        returnButton.frame = CGRectMake(140, 70, 100, 40);
        [returnButton setTitle:@"Return" forState:UIControlStateNormal];
        [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [returnButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]]; // 设置按钮半透明背景色
        returnButton.layer.cornerRadius = 10; // 设置按钮圆角
        [returnButton addTarget:self action:@selector(returnButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:returnButton];
    }
    return self;
}

- (void)againButtonTapped {
    if (self.againActionBlock) {
        self.againActionBlock();
    }
}

- (void)returnButtonTapped {
    if (self.returnActionBlock) {
        self.returnActionBlock();
    }
}

@end

