//
//  InitHomeNavigationViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/27.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "InitHomeNavigationViewController.h"

@interface InitHomeNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation InitHomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //设置navigationbar为透明
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage=[UIImage new];


    


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
