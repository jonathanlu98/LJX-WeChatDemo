//
//  SignUpViewController.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/27.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

//@property (nonatomic, assign) CGRect        tableViewFrame;
// 存放Cell上各行textLabel值
@property (nonatomic, copy)NSMutableArray * textLabel_MArray;


@property(strong,nonatomic) UITextField *setUserNameTextField;
@property(strong,nonatomic) UITextField *setPhoneNumberTextField;
@property(strong,nonatomic) UITextField *setPasswordTextField;
@property(strong,nonatomic) UITextField *verifyPasswordTextField;
@property(strong,nonatomic) NSString *UserName;
@property(strong,nonatomic) NSString *PhoneNumber;
@property(strong,nonatomic) NSString *Password;
@property(strong,nonatomic) NSString *VerifyPassword;


@end
