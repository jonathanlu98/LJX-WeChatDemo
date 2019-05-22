//
//  HomeBarViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/16.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "HomeBarViewController.h"
#import "HomePageDiscovery/DiscoveryViewController.h"
#import "HomePageMe/HomePageMeViewController.h"
#import "HomePageMessage/HomePageMessageViewController.h"
#import "HomePageAddressList/HomePageAddressListViewController.h"
#import "DiscoveryTableView.h"

#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
@interface HomeBarViewController ()
{
    
}

@end

@implementation HomeBarViewController

- (void)viewDidLoad {


        

    [super viewDidLoad];



    [self loadViewControllers];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViewControllers {
    
    HomePageMessageViewController *homePageMessage=[HomePageMessageViewController new];
    UINavigationController *firstNC=[[UINavigationController alloc]initWithRootViewController:homePageMessage];
    homePageMessage.title=@"微信";
    [self createVCIcon:firstNC imageName:@"tabbar_mainframe"];
    
    HomePageAddressListViewController *homePageAddressList=[HomePageAddressListViewController new];
    UINavigationController *secondNC=[[UINavigationController alloc]initWithRootViewController:homePageAddressList];
    homePageAddressList.title=@"通讯录";
    [self createVCIcon:secondNC imageName:@"tabbar_contacts"];
    
    DiscoveryViewController *discoveryTableView=[DiscoveryViewController new];
    UINavigationController *thirdNC=[[UINavigationController alloc]initWithRootViewController:discoveryTableView];
    discoveryTableView.title=@"发现";
    [self createVCIcon:thirdNC imageName:@"tabbar_discover"];
    
    HomePageMeViewController *homePageMe=[HomePageMeViewController new];
    UINavigationController *fourthNC=[[UINavigationController alloc]initWithRootViewController:homePageMe];
    homePageMe.title=@"我";
    [self createVCIcon:fourthNC imageName:@"tabbar_me"];

    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //将四个视图加到tabbar中
    NSArray *controllersArray=@[firstNC,secondNC,thirdNC,fourthNC];
    [self setViewControllers:controllersArray animated:NO];

}
//设置底部栏的图标的方法
- (void)createVCIcon:(UIViewController *)vc imageName:(NSString *)imageName
{
    
    
   
    vc.tabBarItem.image = [UIImage imageNamed:imageName];

    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"HL"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选择后的字体颜色
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
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
