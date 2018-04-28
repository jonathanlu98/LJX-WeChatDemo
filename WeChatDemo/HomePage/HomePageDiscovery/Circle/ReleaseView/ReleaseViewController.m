//
//  ReleaseViewController.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/13.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "ReleaseViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CircleViewController.h"
@interface ReleaseViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.title=@"发表";
    
//    UIImage *imageBar=[UIImage imageNamed:@"Bar"];
//    //设置导航栏背景颜色
//    [self.navigationController.navigationBar setBackgroundImage:imageBar forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton:)];
    cancel.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=cancel;
    
    UIBarButtonItem  *release=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(releaseButton:)];
    release.tintColor=[UIColor greenColor];
    
    self.navigationItem.rightBarButtonItem=release;
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AVAnalytics beginLogPageView:@"PublishView"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [AVAnalytics endLogPageView:@"PublishView"];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入文字"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入文字";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) setupUI {
    self.imageView.image = self.selectedImage;
    self.descriptionTextView.delegate = self;
    [self.indicatorView setHidden:YES];
}
-(void)cancelButton:(UIButton *)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)releaseButton:(UIButton *)sender{
    [self.indicatorView startAnimating];
    [self.indicatorView setHidden:NO];
    
    NSString *description = self.descriptionTextView.text;
    
    // 保存商品信息
    // LeanCloud - 构建图片
    // https://leancloud.cn/docs/leanstorage_guide-ios.html#从数据流构建文件
    NSData *data = UIImagePNGRepresentation(self.selectedImage);
    AVFile *file = [AVFile fileWithData:data];
    // LeanCloud - 获取当前用户
    // https://leancloud.cn/docs/leanstorage_guide-ios.html#当前用户
    AVUser *currentUser = [AVUser currentUser];
    
    // LeanCloud - 保存对象
    // https://leancloud.cn/docs/leanstorage_guide-ios.html#对象
    AVObject *product = [AVObject objectWithClassName:@"Product"];
    
    
    // owner 字段为 Pointer 类型，指向 _User 表
    [product setObject:currentUser forKey:@"owner"];
    // image 字段为 File 类型
    [product setObject:file forKey:@"image"];
    [product setObject:description forKey:@"description"];
    [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.indicatorView setHidden:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"保存新物品出错 %@", error);
            [self showError:@"发布失败！"];
        }
    }];

}
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
@end
