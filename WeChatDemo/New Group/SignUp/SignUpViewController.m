//
//  SignUpViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/27.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "SignUpViewController.h"
#import "InitHomeViewController.h"
#import "HomeBarViewController.h"
#import "IQKeyboardManager.h"
#import <AVOSCloud/AVOSCloud.h>

@interface SignUpViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];



   
    UITableView *signUpTV=[[UITableView alloc] initWithFrame:CGRectMake(16, 145, 343, 304) style:UITableViewStylePlain];
    signUpTV.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 80)];
    signUpTV.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    signUpTV.sectionHeaderHeight=80;
    signUpTV.sectionFooterHeight=0;
    signUpTV.backgroundColor=[UIColor clearColor];
    
//    signUpTV.userInteractionEnabled=YES;
    
    signUpTV.bounces=NO;
    
    signUpTV.delegate=self;
    signUpTV.dataSource=self;
    
    [self.view addSubview:signUpTV];
    


    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didSelectSignUp:(id)sender {

    AVUser *user = [AVUser user];// 新建 AVUser 对象实例

    user.username=self.UserName;
    user.mobilePhoneNumber=self.PhoneNumber;
    user.password=self.Password;
    
    BOOL res=[self.Password isEqualToString:self.VerifyPassword];
    if(res==YES){
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 注册成功
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasUsed"];
                    HomeBarViewController *hBVC=[HomeBarViewController new];
                UIWindow *window = [UIApplication sharedApplication].keyWindow; //获得主窗口
                window.rootViewController = hBVC; //将主窗口的根视图设置为当前控制器
                
            } else {
                // 失败的原因可能有多种，常见的是用户名已经存在。
                
                NSLog(@"注册失败 %@",error);
              [self showError:@"注册失败！"];
            }
        }];
    }
    else
    {
        [self showError:@"您的密码输入不相符!"];
    }
}

//    [self.navigationController pushViewController:hBVC animated:NO];



#pragma mark - 封装弹出对话框方法
// 提示错误信息
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
    return 4;
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
    _textLabel_MArray=[[NSMutableArray alloc]initWithObjects:@"    用户名",@"    手机号",@"设置密码",@"确认密码",nil];
    
    cell.textLabel.text         = [_textLabel_MArray objectAtIndex:indexPath.row];
    //取消cell的选中转台为灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    取消cell右侧导航图标
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if(indexPath.section==0){
        if(indexPath.row==0){
            self.setUserNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(90, 12, 246, 33)];
            self.setUserNameTextField.text=nil;
            self.setUserNameTextField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"请设置用户名作为微信号"];
            self.setUserNameTextField.clearButtonMode = UITextFieldViewModeAlways;
            self.setUserNameTextField.delegate=self;
             [self.setUserNameTextField addTarget:self action:@selector(textFieldUserName:) forControlEvents:UIControlEventEditingDidEnd];
            [cell addSubview:self.setUserNameTextField];
           
            
            
            
        }
        else if(indexPath.row==1){
            self.setPhoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(90, 12, 300, 33)];
            self.setPhoneNumberTextField.placeholder=@"请输入手机号";
            self.setPhoneNumberTextField.delegate=self;
            
            self.setPhoneNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
             [self.setPhoneNumberTextField addTarget:self action:@selector(textFieldPhoneNumber:) forControlEvents:UIControlEventEditingDidEnd];
            [cell addSubview:self.setPhoneNumberTextField];
        
            
        }
        else if (indexPath.row==2){
            self.setPasswordTextField=[[UITextField alloc]initWithFrame:CGRectMake(90, 12, 354, 33)];
            [self.setPasswordTextField setSecureTextEntry:YES];
            self.setPasswordTextField.placeholder=@"设置你的密码";
            self.setPasswordTextField.delegate=self;
             [self.setPasswordTextField addTarget:self action:@selector(textFieldPassword:) forControlEvents:UIControlEventEditingDidEnd];
            [cell addSubview:self.setPasswordTextField];
   
            
        }
        else if (indexPath.row==3){
            
            self.verifyPasswordTextField=[[UITextField alloc]initWithFrame:CGRectMake(90, 12, 408, 33)];
            self.verifyPasswordTextField.placeholder=@"确认你的密码";
            self.verifyPasswordTextField.delegate=self;
            [self.verifyPasswordTextField setSecureTextEntry:YES];
             [self.verifyPasswordTextField addTarget:self action:@selector(textFieldVerifyPassword:) forControlEvents:UIControlEventAllEditingEvents];
            [cell addSubview:self.verifyPasswordTextField];

            
        }}
    

    
    return cell;
}
-(void)textFieldUserName:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.UserName = field.text;
}
-(void)textFieldPhoneNumber:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.PhoneNumber = field.text;
}
-(void)textFieldPassword:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.Password = field.text;
}
-(void)textFieldVerifyPassword:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.VerifyPassword = field.text;
}


//设置cell的宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}
/*+
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
