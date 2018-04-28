//
//  DiscoveryTableView.m
//  WeChatDemo
//
//  Created by Jonathan Lu on 2018/3/16.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "DiscoveryTableView.h"
#import "DiscoveryViewController.h"
#import "CircleViewController.h"
#import "Scan/ScanViewController.h"
@interface DiscoveryTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DiscoveryTableView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        // Initialization code   使用代理
        self.delegate   = self;
        self.dataSource = self;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code   使用代理
        self.delegate   = self;
        self.dataSource = self;
    }
    return self;
}

-(void)setTableViewFrame:(CGRect)tableViewFrame
{
    self.frame = tableViewFrame;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
#pragma mark - table view data source

// tableView分区数量，可为其设置为多个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

// tableView每个分区的行数，可以为各个分区设置不同的行数，根据section的值判断即可
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (0 == section) {
        return 1;
    }
    else if(section==1){
        return 2;
    }
    else if(section==2){
        return 2;
    }
    else if(section==3){
        return 2;
    }
    else if(section==4){
        return 2;
    }
    else if (section==5){
        return 1;
    }
    
    return 1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    cell.textLabel.text         = [_textLabel_MArray objectAtIndex:indexPath.row];
    
    // 设置每一行的图片
    cell.imageView.image        = [_images_MArray objectAtIndex:indexPath.row];
    
    //设置每个section 每行的文本 和图片

    if(indexPath.section==0)
    {
        cell.textLabel.text = @"朋友圈";
        cell.imageView.image=[UIImage imageNamed:@"1"];
        [self changeIconWith:cell];

        
        
    }
    else if (indexPath.section==1) {
        if(indexPath.row==0){
            cell.textLabel.text = @"扫一扫";
            cell.imageView.image=[UIImage imageNamed:@"2"];
            [self changeIconWith:cell];
            
        }
        else if(indexPath.row==1){
            cell.textLabel.text = @"摇一摇";
            cell.imageView.image=[UIImage imageNamed:@"3"];
            [self changeIconWith:cell];
        }
    }
    else if (indexPath.section==2) {
        if(indexPath.row==0){
            cell.textLabel.text = @"看一看";
            cell.imageView.image=[UIImage imageNamed:@"4"];
            [self changeIconWith:cell];
        }
        else if (indexPath.row==1){
            cell.textLabel.text = @"搜一搜";
            cell.imageView.image=[UIImage imageNamed:@"5"];
            [self changeIconWith:cell];
        }
    }
    else if (indexPath.section==3){
        if(indexPath.row==0){
            cell.textLabel.text = @"附近的人";
            cell.imageView.image=[UIImage imageNamed:@"6"];
            [self changeIconWith:cell];
        }
        else if(indexPath.row==1){
            cell.textLabel.text = @"漂流瓶";
            cell.imageView.image=[UIImage imageNamed:@"7"];
            [self changeIconWith:cell];
        }
    }
    else if(indexPath.section==4){
        if(indexPath.row==0){
            cell.textLabel.text = @"购物";
            cell.imageView.image=[UIImage imageNamed:@"8"];
            [self changeIconWith:cell];
        }
        else if(indexPath.row==1){
            cell.textLabel.text = @"游戏";
            cell.imageView.image=[UIImage imageNamed:@"9"];
            [self changeIconWith:cell];
        }
    }
    else if(indexPath.section==5){
        cell.textLabel.text = @"小程序";
        cell.imageView.image=[UIImage imageNamed:@"10"];
        [self changeIconWith:cell];
    }
    
    
    
    return cell;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
//设置section顶部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 9;
}
//设置section顶部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 11;}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//设置cell的宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}
//调整图片的尺寸
-(void)changeIconWith:(UITableViewCell *)cell
{
    CGSize itemSize = CGSizeMake(20, 20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

//设置cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    CircleViewController *cVC=[[CircleViewController alloc]init];
    ScanViewController *sVC=[[ScanViewController alloc]init];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    id object=[self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] && object != nil) {
        object = [object nextResponder];
    }
    
    DiscoveryViewController *superConroller=(DiscoveryViewController *)object;
    if (indexPath.section==0) {
        [superConroller.navigationController pushViewController:cVC animated:YES];
           [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else if(indexPath.section==1) {
        if(indexPath.row==0) {
            [superConroller.navigationController pushViewController:sVC animated:YES];
        }
    }
        
   

}



@end
