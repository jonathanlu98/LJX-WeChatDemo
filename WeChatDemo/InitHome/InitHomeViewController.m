//
//  InitHomeViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/21.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "InitHomeViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface InitHomeViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *signup;

@end

@implementation InitHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//
//    状态栏的字体为黑色： UIStatusBarStyleDefault
//    状态栏的字体为白色： UIStatusBarStyleLightContent
    self.navigationController.navigationBar.barStyle=UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain  target:nil action:nil];
   
   [self.navigationItem setBackBarButtonItem:bar];
    

    
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)didSelectLogin:(id)sender {
    
   
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
- (IBAction)didSelectSignUp:(id)sender {
    SignUpViewController *signUpVC=[SignUpViewController new];
    [self.navigationController pushViewController:signUpVC animated:YES];
    

}


//push
//[self.navigationController pushViewController:ViewController animated:YES]; //入栈，跳转到指定控制器视图
//[self.navigationController popViewControllerAnimated:YES]; //弹栈，返回到前一个视图
//[self.navigationController popToViewController:ViewController animated:YES]; //弹栈 返回指定控制器所在视图
//[self.navigationController popToRootViewControllerAnimated:YES]; //弹栈 返回根控制器视图

//modal
//[self presentViewController:ViewController animated:YES completion:nil]; //跳转到ViewController所在视图
//[self dismissModalViewControllerAnimated:YES]; //退出当前视图

//切换window的rootViewController
//UIWindow *window = [UIApplication sharedApplication].keyWindow; //获得主窗口
//window.rootViewController = [[ViewController alloc] init]; //将主窗口的根视图设置为当前控制器

//将另一个控制器的视图添加为当前控制器视图的子视图
//[self.view addSubview: ViewController.View]; //实现复杂界面的时候常用


@end
