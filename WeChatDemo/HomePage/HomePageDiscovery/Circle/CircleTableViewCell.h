//
//  CircleTableViewCell.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/11.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleModel;

@interface CircleTableViewCell : UITableViewCell

{
   @public
    CGFloat imageWidth;
    CGFloat imageHeight;
}
@property (nonatomic, strong) CircleModel *model;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end
