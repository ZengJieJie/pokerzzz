//
//  AppDelegate.m
//  3Patti puke
//
//  Created by adin on 2024/3/25.
//

#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKSettings sharedSettings] setAdvertiserIDCollectionEnabled:YES];
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    //每个包的af参数由甲方生成
    [[AppsFlyerLib shared] setAppsFlyerDevKey:@"com.pokerzjjj.b62"];
    [[AppsFlyerLib shared] setAppleAppID:@"6480452840"];
    [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:20];
    [[AppsFlyerLib shared] start];
    
    [[FBSDKAppEvents shared] logEvent:@"battledAnOrc"];
    
    // Override point for customization after application launch.
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options{
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FBSDKAppEvents shared] activateApp];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5f*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (@available(iOS 14, *)) {
            if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined) {
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus s) {}];
            }
        }
    });
}




@end
