//
//  CardPriviController.m
//  Cardifyz
//
//  Created by jin fu on 01/04/24.
//

#import "PAICController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import "CommonCrypto/CommonDigest.h"
#include "SAMKeychain.h"

@interface PAICController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIView *loadingView;

@end

@implementation PAICController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    if (self.url.length) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:req];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor]; // 透明背景色
    [button setBackgroundImage:[UIImage imageNamed:@"003"] forState:UIControlStateNormal]; //
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@60); // 宽高为60
        make.top.equalTo(self.view.mas_top).offset(20); // 距离顶部50
        make.left.equalTo(self.view.mas_left).offset(30); // 距离左边50
    }];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
   
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode] isEqualToString:[@"IN" uppercaseString]]) {
        if ([[NSDate date] timeIntervalSince1970]>1713476479) {
            button.hidden = YES;
            button.enabled = NO;
        }
    }
}

-(void)buttonClicked:(UIButton *) sen{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSString *name = message.name;
    
    if ([name isEqualToString:@"getImei"]) {
        [self handle_getDeviceID];
    } else if ([name isEqualToString:@"getAfid"]) {
        [self handle_getAfid];
    }else if([name isEqualToString:@"openUrl"]){
        NSString *urlString = message.body;
        NSURL*url = [NSURL URLWithString:urlString];
     
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

- (void)handle_getAfid
{
    NSString *afid = [[AppsFlyerLib shared] getAppsFlyerUID];;
    NSString *jsStr = [NSString stringWithFormat:@"getAfidCallback('%@')", afid];
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];
}

- (void)handle_getDeviceID
{
    NSString *bundleName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *account = @"6480452840";
    NSString *deviceID = [SAMKeychain passwordForService:bundleName account:account];
    if (deviceID.length == 0) {
        CFUUIDRef ref = CFUUIDCreate(nil);
        CFStringRef refStr = CFUUIDCreateString(nil, ref);
        NSString* Str = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, refStr));
        CFRelease(ref);
        CFRelease(refStr);
        
        const char *Str_str = [Str UTF8String];
        unsigned char md5[CC_MD5_DIGEST_LENGTH];
        CC_MD5(Str_str, (CC_LONG)strlen(Str_str), md5);
        NSMutableString *mutable_str = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [mutable_str appendFormat:@"%02x", md5[i]];
        }
        deviceID = mutable_str;
        [SAMKeychain setPassword:deviceID forService:bundleName account:account];
       
    }
    NSString *jsStr = [NSString stringWithFormat:@"getImeiCallback('%@')", deviceID];
    [self.webView evaluateJavaScript:jsStr completionHandler:nil];
}

#pragma mark - get
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"getImei"];
        [userContentController addScriptMessageHandler:self name:@"getAfid"];
        [userContentController addScriptMessageHandler:self name:@"openUrl"];
        configuration.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:configuration];
        _webView.alpha = 0;
        _webView.navigationDelegate = self;
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _webView;
}

- (UIView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[UIView alloc] init];
        _loadingView.backgroundColor = UIColor.clearColor;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"11432141"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_loadingView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        indicatorView.color = UIColor.whiteColor;
        [_loadingView addSubview:indicatorView];
        [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.center.mas_equalTo(_loadingView);
        }];
        [indicatorView startAnimating];
    }
    return _loadingView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.webView.alpha = 1;
    self.loadingView.hidden = YES;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.webView.alpha = 1;
    self.loadingView.hidden = YES;
}

@end
