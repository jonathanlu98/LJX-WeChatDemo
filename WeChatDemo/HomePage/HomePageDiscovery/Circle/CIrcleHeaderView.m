//
//  CIrcleHeaderView.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/10.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "CIrcleHeaderView.h"
#import "UIView+SDAutoLayout.h"
#import <AVOSCloud/AVOSCloud.h>


@implementation CIrcleHeaderView
{
    UIImageView *_backgroundImageView;
    UIImageView *_iconView;
    UILabel *_nameLabel;



}

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {


        [self setup];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setupUI
{


    
    AVFile *backgroundFile=[self.object valueForKey:@"user_background"];
    [backgroundFile downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
        self->_backgroundImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
    }];

    
    
    AVFile *iconFile=[self.object valueForKey:@"user_icon"];
    [iconFile downloadWithCompletionHandler:^(NSURL * filePath, NSError * error) {
        self->_iconView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
    }];

    



   
    
    
  
}
-(void) setup{

    _backgroundImageView = [UIImageView new];
    _backgroundImageView.backgroundColor =[UIColor colorWithRed:38/256.0 green:38/256.0 blue:38/256.0 alpha:1];
    _backgroundImageView.tintColor=[UIColor blackColor];
    [self addSubview:_backgroundImageView];
    
    _iconView = [UIImageView new];
    _iconView.backgroundColor =[UIColor colorWithRed:173/256.0 green:193/256.0 blue:197/256.0 alpha:1];
    _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconView.layer.borderWidth = 3;

    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];

    

    [self addSubview:_iconView];
    [self addSubview:_nameLabel];

    
    _iconView.sd_layout
    .widthIs(70)
    .heightIs(70)
    .rightSpaceToView(self, 15)
    .bottomSpaceToView(self, 20);
    

    _nameLabel.tag = 1000;
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _nameLabel.sd_layout
    .rightSpaceToView(_iconView, 20)
    .bottomSpaceToView(_iconView, -35)
    .heightIs(20);
    
    _backgroundImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 40, 0));
    

    
    AVUser *owner=[AVUser currentUser];
    
    
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:[owner objectId] block:^(AVObject *object, NSError *error) {
        if (!error) {
        self.object=object;
            [self setupUI];
        }
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
