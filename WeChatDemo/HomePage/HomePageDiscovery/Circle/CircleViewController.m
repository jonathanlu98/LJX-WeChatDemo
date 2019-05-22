//
//  CircleViewController.m
//  WeChatDemo
//
//  Created by JonathanLu on 2018/3/17.
//  Copyright © 2018年 Jonathan Lu. All rights reserved.
//

#import "CircleViewController.h"
#import "CIrcleHeaderView.h"
#import "CircleTableViewCell.h"
#import "WeChatCirclePhotoContainerView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CircleModel.h"
#import "SDRefreshFooterView.h"
#import "SDRefreshHeaderView.h"
#import "ReleaseViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#define CirCleTableViewCellId @"CircleTableViewCell"


@interface CircleViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) __block NSArray *iconImageNamesArray;
@property (strong, nonatomic) __block NSArray *namesArray;
@property (strong, nonatomic) __block NSArray *textArray;
@property (strong, nonatomic) __block NSArray *picImageNamesArray;

@property (nonatomic, strong) __block NSMutableArray *modelsArray;
@property (strong, nonatomic) __block NSArray *products;
@end

@implementation CircleViewController
{
    SDRefreshFooterView *_refreshFooter;
}
- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.navigationItem.title=@"朋友圈";
    
    
    
//    __weak typeof(self) weakSelf = self;
//
//    // 上拉加载
//    _refreshFooter = [SDRefreshFooterView refreshView];
//    [_refreshFooter addToScrollView:self.tableView];
//    __weak typeof(_refreshFooter) weakRefreshFooter = _refreshFooter;
//    _refreshFooter.beginRefreshingOperation = ^() {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf creatModelsWithCount:10];
////            [weakSelf.tableView reloadData];
//            [weakRefreshFooter endRefreshing];
//        });
//    };
//
    
//设置朋友圈顶部的视图view
    CIrcleHeaderView *headerView = [[CIrcleHeaderView alloc]initWithFrame:CGRectMake(0, 0, 0, 300)];

    self.tableView.tableHeaderView = headerView;
     [self.tableView registerClass:[CircleTableViewCell class] forCellReuseIdentifier:CirCleTableViewCellId];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.estimatedRowHeight = 100;

    
//    [self creatModelsWithCount:[_iconImageNamesArray count]];
//
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
}

- (instancetype)init {
    //隐藏底部的书签栏
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self addRightButton];

    return [super init];
}
- (void) setupData {
    // LeanCloud - 查询 - 获取商品列表
    // https://leancloud.cn/docs/leanstorage_guide-ios.html#查询
    AVQuery *query = [AVQuery queryWithClassName:@"Product"];
    [query orderByDescending:@"createdAt"];
    // owner 为 Pointer，指向 _User 表
    [query includeKey:@"owner"];
    // image 为 File
    [query includeKey:@"image"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.products = objects;
            [self.tableView reloadData];
           __block NSMutableArray *namesArray;
           __block NSMutableArray *iconImageNamesArray;
           __block NSMutableArray *textArray;
           __block NSMutableArray *picImageNamesArray;
            
            
            for(int i=0;i<[objects count];i++){
                AVObject *product = objects[i];
                AVUser *owner=[product objectForKey:@"owner"];
                namesArray[i]=[owner valueForKey:@"nickname"];

                
                textArray[i]=[NSString stringWithFormat:@"%@",[product objectForKey:@"description"]];
                
                AVFile *icon=[owner objectForKey:@"user_icon"];
                [icon downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
                    iconImageNamesArray[i]=filePath;
                }];
                
                AVFile *image=[product objectForKey:@"image"];
                [image downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
                    picImageNamesArray[i]=filePath;
                }];
                [self.tableView reloadData];
                
            }
            self.textArray=textArray;
            self.namesArray=namesArray;
            self.picImageNamesArray=picImageNamesArray;
            self.iconImageNamesArray=iconImageNamesArray;
            
            
        }
        
    }];
   
   
    
}


- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }

    
//    self.iconImageNamesArray = @[@"icon0.jpg",
//                                     @"icon1.jpg",
//                                     @"icon2.jpg",
//                                     @"icon3.jpg",
//                                     @"icon4.jpg",
//                                     ];
//
//    self.namesArray = @[@"GSD_iOS",
//                            @"风口上的猪",
//                            @"当今世界网名都不好起了",
//                            @"我叫郭德纲",
//                            @"Hello Kitty"];
//
//    self.textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
//                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
//                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
//                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
//                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
//                           ];
//
//    NSArray *picImageNamesArray = @[ @"pic0.jpg",
//                                     @"pic1.jpg",
//                                     @"pic2.jpg",
//                                     @"pic3.jpg",
//                                     @"pic4.jpg",
//                                     @"pic5.jpg",
//                                     @"pic6.jpg",
//                                     @"pic7.jpg",
//                                     @"pic8.jpg"
//                                     ];
    
    for (int i = 0; i < [_textArray count]; i++) {
        CircleModel *model = [CircleModel new];
        model.iconName = _iconImageNamesArray[i];
        model.name = _namesArray[i];
        model.content = _textArray[i];

        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < [_picImageNamesArray count]; i++) {
            [temp addObject:_picImageNamesArray[i]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }

        [self.modelsArray addObject:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CircleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(!cell){
            cell = [tableView dequeueReusableCellWithIdentifier:CirCleTableViewCellId];
    }
    
    cell.separatorInset=UIEdgeInsetsMake(0.1, 100, 0.1, 0.1);
    


    AVObject *product = self.products[indexPath.row];
    AVUser *owner=[self.products[indexPath.row] objectForKey:@"owner"];
    AVFile *icon=[[self.products[indexPath.row] objectForKey:@"owner"] objectForKey:@"user_icon"];
    [icon downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {
        cell.iconView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
    }];

    
    AVFile *image=[product objectForKey:@"image"];
    if(image.url==nil){
        [cell.circleImageView removeFromSuperview];

    }
    

    [image downloadWithCompletionHandler:^(NSURL * _Nullable filePath, NSError * _Nullable error) {

        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
        cell->imageWidth=image.size.width;
        cell->imageHeight=image.size.height;
        
//        [cell setNeedsUpdateConstraints];
//        [cell updateConstraintsIfNeeded];
        
        cell.circleImageView.image=image;
    }];

    cell.nameLabel.text=[owner valueForKey:@"nickname"];
    
    cell.contentLabel.text=[NSString stringWithFormat:@"%@", [product objectForKey:@"description"]];
    
    
    
    
    
    
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    CGFloat h = [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return h;
}

-(void)addRightButton
{
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(btnClick:)];
    [selectButton setStyle:UIBarButtonItemStylePlain];
    self.navigationItem.rightBarButtonItem = selectButton;
    
}
- (void)btnClick:(UIButton *)sender

{
    
    [self openActionSheetFunc];
    
}



//调用

- (void)openActionSheetFunc

{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.navigationBar.barStyle=UIBarStyleBlack;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
}];
        [alertC addAction:camera];
    }
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.navigationBar.barStyle=UIBarStyleBlack;
//        
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
            
//        }
        
        pickerImage.delegate = self;
        
        pickerImage.allowsEditing = YES;
        
        
        
        [self presentViewController:pickerImage animated:YES completion:nil];
        
    }];
    
    [alertC addAction:cancle];
    [alertC addAction:picture];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
}


// 选择图片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
    
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
////    [self performSegueWithIdentifier:@"toRelaseView" sender:selectedImage];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//
//    //当选择的类型是图片
//
//    if ([type isEqualToString:@"public.image"])
//
//    {
//
//        //先把图片转成NSData
//
//        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//
//        NSData *data;
//
//        if (UIImagePNGRepresentation(image) ==nil)
//
//        {
//
//            data = UIImageJPEGRepresentation(image,1.0);
//
//        }
//
//        else
//
//        {
//
//            data = UIImagePNGRepresentation(image);
//
//        }
//
//
//        //图片保存的路径
//
//        //这里将图片放在沙盒的documents文件夹中
//
//        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//
//
//        //文件管理器
//
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//
//
//        //把刚刚图片转换的data对象拷贝至沙盒中并保存为image.png
//
//        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//
//        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/userHeader.png"] contents:data attributes:nil];
//
    
        
        //关闭相册界面
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        

    // }
        //加在视图中
    ReleaseViewController *releaseVC=[[ReleaseViewController alloc]init];
    releaseVC.selectedImage=selectedImage;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:releaseVC];
    [self presentViewController:nav animated:YES completion:nil];
   
    
}

// 取消选取图片

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


//#pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString: @"toRelaseView"]) {
//        UINavigationController *navigationController = [segue destinationViewController];
//        ReleaseViewController *vc = (ReleaseViewController *) [navigationController topViewController];
//        [self.inputView addSubview:vc.view];
//        UIImage *image = (UIImage *) sender;
//    }
//}

    










@end
