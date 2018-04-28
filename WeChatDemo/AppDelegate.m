//
//  AppDelegate.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/15.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeBarViewController.h"
#import "DiscoveryViewController.h"
#import "InitHomeViewController.h"
#import "InitHomeNavigationViewController.h"
#import "IQKeyboardManager.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupNavBar];
    //设置启动界面的加载时间
    [NSThread sleepForTimeInterval:1.0];
    

    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    //设置为文字
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";

    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
//    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
//
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体

    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

    
    
    // 使用美国站点需要增加以下代码：
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    
//    [AVOSCloud setApplicationId:@"kheiCCXbvn2XJ9LIRg4gu6ex-gzGzoHsz" clientKey:@"VRe7L4lJhytTHNCzEqINxsJe"];
    
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    
    [AVOSCloud setApplicationId:@"kheiCCXbvn2XJ9LIRg4gu6ex-gzGzoHsz" clientKey:@"VRe7L4lJhytTHNCzEqINxsJe"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
    LoginViewController *loginVC=[LoginViewController new];
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunch"] == NO) {
        NSLog(@"第一次启动");
        
   InitHomeNavigationViewController *initHNC=[[InitHomeNavigationViewController alloc]initWithRootViewController:[[InitHomeViewController alloc]init]];
         self.window.rootViewController = initHNC;

    }else if([loginVC.standardUserDefaults boolForKey:@"everLaunch"] == YES){
        NSLog(@"非第一次启动");
        self.window.rootViewController = [[HomeBarViewController alloc] init];
    }
    
    
    

    
//
//    //设置状态栏的样式
//    application.statusBarStyle = UIStatusBarStyleLightContent;
//
//    //程序启动完后显示状态栏
//    application.statusBarHidden = NO;
//
    // Override point for customization after application launch.

    return YES;
    

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//
//{
//
//    NSString *text = [textField.textstringByReplacingCharactersInRange:range withString:string];
//
//    return YES;
//
//}
- (void)setupNavBar
{
    
    
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.015;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}
@end
