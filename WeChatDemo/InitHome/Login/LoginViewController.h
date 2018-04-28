//
//  LoginViewController.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/21.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

// 存放Cell上各行textLabel值
@property (nonatomic, copy)NSMutableArray * textLabel_MArray;


@property (strong,nonatomic) UITextField *accountTextField;
@property (strong,nonatomic) UITextField *passwordTextField;

@property(nonatomic,strong)NSUserDefaults *standardUserDefaults;


@end
