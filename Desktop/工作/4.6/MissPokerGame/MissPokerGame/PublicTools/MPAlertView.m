//
//  MPAlertView.m
//  MissPokerGame
//
//  Created by mac on 2024/4/4.
//

#import "MPAlertView.h"


@interface MPAlertView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *confirmTitle;
@property (nonatomic, copy) NSString *cancelTitle;
@end
@implementation MPAlertView

- (instancetype)initWithTitle:(NSString*)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    if (self) {
        self.title = title;
        self.confirmTitle = confirmTitle;
        self.cancelTitle = cancelTitle;
        [self setupViews];
        [self setupConstraints];
        [self setupActions];
    }
    return self;
}

- (void)setupViews {
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.backgroundView];
    
    self.dialogView = [[UIView alloc] init];
    self.dialogView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];;
    self.dialogView.layer.cornerRadius = 10;
    self.dialogView.layer.borderWidth = 1.f;
    self.dialogView.layer.borderColor = UIColorHex(0x1296db).CGColor;
    self.dialogView.clipsToBounds = YES;
    self.dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.dialogView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal]; // 请替换成关闭图标的图片
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dialogView addSubview:self.closeButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dialogView addSubview:self.titleLabel];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.confirmButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = UIColorHex(0x1296db);
    self.confirmButton.layer.cornerRadius = 5.f;
    self.confirmButton.clipsToBounds = YES;
    [self.confirmButton setTitle:@"sure" forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dialogView addSubview:self.confirmButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.cancelButton.backgroundColor = UIColor.whiteColor;
    self.cancelButton.layer.cornerRadius = 5.f;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dialogView addSubview:self.cancelButton];
    
    self.titleLabel.text = self.title;
    [self.cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
    [self.confirmButton setTitle:self.confirmTitle forState:UIControlStateNormal];
}

- (void)setupConstraints {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.dialogView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.height.mas_equalTo(150);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dialogView.mas_top).offset(10);
        make.right.equalTo(self.dialogView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dialogView.mas_top).offset(30);
        make.centerX.equalTo(self.dialogView.mas_centerX).offset(0);
    }];
    if (self.cancelTitle.length < 1) {
        self.cancelButton.hidden = YES;
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.dialogView.mas_centerX).offset(0);
            make.bottom.equalTo(self.dialogView.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
    } else {
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dialogView.mas_left).offset(30);
            make.bottom.equalTo(self.dialogView.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.dialogView.mas_right).offset(-30);
            make.bottom.equalTo(self.dialogView.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
    }
}

- (void)setupActions {
    [self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:window.topAnchor],
        [self.leadingAnchor constraintEqualToAnchor:window.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:window.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:window.bottomAnchor]
    ]];
    
    self.alpha = 0;
    self.dialogView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.dialogView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.dialogView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closeButtonTapped {
    if (self.closeAction) {
        self.closeAction();
    }
    [self dismiss];
}

- (void)confirmButtonTapped {
    if (self.confirmAction) {
        self.confirmAction();
    }
    [self dismiss];
}

- (void)cancelButtonTapped {
    if (self.cancelAction) {
        self.cancelAction();
    }
    [self dismiss];
}

@end
