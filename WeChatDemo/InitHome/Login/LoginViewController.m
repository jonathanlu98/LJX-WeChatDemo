//
//  LoginViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/21.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "LoginViewController.h"
#import "InitHomeViewController.h"
#import "HomeBarViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    UITableView *loginTV=[[UITableView alloc]initWithFrame:CGRectMake(16,250,343,112) style:UITableViewStylePlain];
//    取消cell上下白边
    loginTV.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    loginTV.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    loginTV.sectionHeaderHeight=0;
    loginTV.sectionFooterHeight=0;
    
    
    //是否取用户交互（取消会导致 选中状态消失  滑动状态消失）这里设置为yes
    loginTV.userInteractionEnabled=YES;
    
    //取消tableview的上下滑动
    loginTV.bounces=NO;
    
    self.textLabel_MArray=[[NSMutableArray alloc]initWithObjects:@"手机号/微信号",@"                密码", nil];
    loginTV.delegate=self;
    loginTV.dataSource=self;
    [self.view addSubview:loginTV];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didSelectLoginSucess:(id)sender {
    HomeBarViewController *hBVC=[HomeBarViewController new];
    
    [AVUser logInWithUsernameInBackground:self.accountTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow; //获得主窗口
            window.rootViewController = hBVC; //将主窗口的根视图设置为当前控制器
            /*
             优点：跳转直接迅速，而且可以销毁前一个控制器，因为将window的强引用改为当前控制器，故前一个控制器会消失（ARC环境）
             缺点：视图跳转不可逆
             */
        } else {
            [AVUser logInWithMobilePhoneNumberInBackground:self.accountTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error){
                if (user != nil) {
                    
                        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"everLaunch"];
                    
                    UIWindow *window = [UIApplication sharedApplication].keyWindow; //获得主窗口
                    window.rootViewController = hBVC; //将主窗口的根视图设置为当前控制器
            }
                else{
                       [self showError:@"登录失败！"];
                   }
            }
             ];
        }
    }];
//    [self presentViewController:hBVC animated:NO completion:nil]; //跳转到ViewController所在视图
//    [self dismissModalViewControllerAnimated:YES]; //退出当前视图    此方法即将废弃！
    

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 为其定义一个标识符，在重用机制中，标识符非常重要，这是系统用来匹配table各行cell的判断标准，在以后的学习中会体会到
    static NSString *cellIdentifier = @"cellIdentifier";
    
    // 从缓存队列中取出复用的cell
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    // 如果队列中cell为空，即无复用的cell，则对其进行初始化
    if (cell==nil) {
        
        // 初始化
        cell                    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        // 定义其辅助样式
        cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;
    }
    // 设置cell上文本内容
    cell.textLabel.text = [_textLabel_MArray objectAtIndex:indexPath.row];
    //取消cell的选中转台为灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    取消cell右侧导航图标
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    
    
    if(indexPath.row==0)
    {
        self.accountTextField=[[UITextField alloc]initWithFrame:CGRectMake(129, 12, 222, 33)];
        
        self.accountTextField.placeholder=@"请输入你的手机号/微信号";
        self.accountTextField.delegate=self;
        
        
        [self.accountTextField becomeFirstResponder];
        
        [self.accountTextField addTarget:self action:@selector(textFieldAccount:) forControlEvents:UIControlEventEditingDidEnd];
        [cell addSubview:self.accountTextField];
        
    }
    else if(indexPath.row==1)
    {
        
        self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(129, 12, 276, 33)];
        
        self.passwordTextField.placeholder=@"请输入你的密码";
        self.passwordTextField.delegate=self;
        [self.passwordTextField setSecureTextEntry:YES];
        [self.passwordTextField addTarget:self action:@selector(textFieldPassword:) forControlEvents:UIControlEventAllEditingEvents];
        [cell addSubview:self.passwordTextField];
    }
    
    return cell;
    
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
//注释部分适用于
////设置section顶部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0;
//}
////设置section顶部视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    view.backgroundColor = [UIColor whiteColor];
//    return view ;
//}
////section底部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;}
////section底部视图
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    view.backgroundColor = [UIColor whiteColor];
//    return view;
//}
//设置cell的宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}
-(void)textFieldAccount:(id)sender{
    UITextField *field=(UITextField *)sender;
    self.accountTextField.text=field.text;
    
}
-(void)textFieldPassword:(id)sender{
     UITextField *field=(UITextField *)sender;
    self.passwordTextField.text=field.text;
}
@end
