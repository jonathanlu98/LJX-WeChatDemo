//
//  MainTableViewController.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/15.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
// tableView的坐标
@property (nonatomic, assign) CGRect        tableViewFrame;

// 存放Cell上各行textLabel值
@property (nonatomic, copy)NSMutableArray * textLabel_MArray;

// 存放Cell上各行imageView上图片
@property (nonatomic, copy)NSMutableArray * images_MArray;

// 存放Cell上各行detailLabel值
@property (nonatomic, copy)NSMutableArray * subtitle_MArray;

@end
