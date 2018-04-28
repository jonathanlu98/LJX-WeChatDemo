//
//  CircleModel.h
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/4/11.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *picNamesArray;
@end
