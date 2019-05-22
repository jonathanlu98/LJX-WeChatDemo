//
//  CircleTableViewCell.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/11.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "CircleTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "CircleModel.h"
#import <AVOSCloud/AVOSCloud.h>

@interface CircleTableViewCell()
@property (strong, nonatomic) NSArray *products;
@end

@implementation CircleTableViewCell
{
//    UIImageView *_iconView;
//    UILabel *_nameLabel;
//    UILabel *_contentLabel;
//    UILabel *_timeLabel;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
//对相关控件进行布局

- (void)setup
{
    
    

    
    _iconView = [UIImageView new];

    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    _circleImageView = [UIImageView new];
    _circleImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    NSArray *views = @[_iconView, _nameLabel, _contentLabel, _circleImageView, _timeLabel];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .widthIs(60)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    

    
    _contentLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topSpaceToView(_nameLabel, margin)
    .rightSpaceToView(contentView, margin);

    
    _circleImageView.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topSpaceToView(_contentLabel, 0)
//    .rightSpaceToView(contentView, margin+20)
//    .maxHeightIs(500);
//    .maxWidthIs(400)
//    .heightIs(imageHeight)
//    .widthIs(imageWidth)
        .maxHeightIs(500)
        .maxWidthIs(300)
    .minWidthIs(200)
    .minHeightIs(200)
    ;
    
    _timeLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topSpaceToView(_circleImageView, margin)
    .heightIs(15)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:margin + 5];
    
    
     CGFloat picContainerTopMargin = 0;
    picContainerTopMargin = 0;
// _circleImageView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
        _timeLabel.text = @"1分钟前";
    
}


//- (void)setModel:(CircleModel *)model
//{
//    _model = model;
//
//
//    _iconView.image = [UIImage imageNamed:model.iconName];
//    _nameLabel.text = model.name;
//    _contentLabel.text = model.content;
//    _picContainerView.picPathStringsArray = model.picNamesArray;
//    CGFloat picContainerTopMargin = 0;
//    if (model.picNamesArray.count) {
//        picContainerTopMargin = 10;
//    }
//    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
//    _timeLabel.text = @"1分钟前";
//}


@end
