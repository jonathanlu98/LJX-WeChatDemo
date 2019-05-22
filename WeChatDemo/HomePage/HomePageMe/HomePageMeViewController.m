//
//  HomePageMeViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/16.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "HomePageMeViewController.h"
#import "InitHomeViewController.h"

@interface HomePageMeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelAccount;

@end

@implementation HomePageMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];



//    UIImage *imageBar=[UIImage imageNamed:@"Bar"];
//    //设置导航栏背景颜色
//    [self.navigationController.navigationBar setBackgroundImage:imageBar forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];

//    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didSelectCancelAccount:(id)sender {
    InitHomeViewController *initHVC=[InitHomeViewController new];
    [self.view addSubview:initHVC.view];
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
