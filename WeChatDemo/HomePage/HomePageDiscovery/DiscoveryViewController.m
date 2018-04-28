//
//  DiscoveryViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/16.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryTableView.h"
#import "Scan/ScanViewController.h"
#import "CircleViewController.h"
@interface DiscoveryViewController ()
{
    DiscoveryTableView *discoveryTableView;
}
@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *imageBar=[UIImage imageNamed:@"Bar"];
//    //设置导航栏背景颜色
//    [self.navigationController.navigationBar setBackgroundImage:imageBar forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//
    //设置navigationbar的字体为白色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    discoveryTableView=[[DiscoveryTableView alloc]initWithFrame:CGRectMake(0,0,375,667) style:UITableViewStyleGrouped];
    
    //自动尺寸调整（autoresizesSubviews属性声明被设置为YES，
//    则其子视图会根据autoresizingMask属性的值自动进行尺寸调整。
//    简单配置一下视图的自动尺寸调整掩码常常就能使应用程序得到合适的行为；否则，
//    应用程序就必须通过重载layoutSubviews方法来提供自己的实现。）

    discoveryTableView.autoresizesSubviews=YES;
    discoveryTableView.textLabel_MArray  = [[NSMutableArray alloc] initWithObjects:@"朋友圈",@"扫一扫",@"摇一摇",@"看一看",@"搜一搜",@"附近的人",@"漂流瓶",@"购物",@"游戏",@"小程序", nil];
    [self.view addSubview:discoveryTableView];// 添加到当前View
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
