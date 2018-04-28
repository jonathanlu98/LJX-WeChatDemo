//
//  ReleaseViewController.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/13.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) NSString *name;
@end
