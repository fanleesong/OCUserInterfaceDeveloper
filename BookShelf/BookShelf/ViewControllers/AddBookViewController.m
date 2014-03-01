//
//  AddBookViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "AddBookViewController.h"
#import "CategoryViewController.h"
#import "DataBaseManager.h"
#import "BookInfo.h"

@interface AddBookViewController ()


@property (nonatomic,retain) UITextField *bookNameTextField;
@property (nonatomic,retain) UILabel *bookCategoryLabel;
@property (nonatomic,retain) UITextField *bookPriceTextField;

@end

@implementation AddBookViewController
-(void)dealloc{

    [_bookCategoryLabel release];
    [_bookPriceTextField release];
    [_bookNameTextField release];
    [super dealloc];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"添加书籍";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.bookCategoryLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Category"];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //调用视图初始化的方法
    [self _initViewBaseComponents];
    [self _initSomeProperty];
}
//实例化属性
-(void)_initSomeProperty{


    //图片
    UIImageView *bookAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 74,100 ,100 )];
    bookAvatar.image = [UIImage imageNamed:@"hihi.png"];
    [self.view addSubview:bookAvatar];
    [bookAvatar release],bookAvatar = nil;
    
    //类别
    self.bookCategoryLabel = [[[UILabel alloc] initWithFrame:CGRectMake(135, 124, 180,40)] autorelease];
    self.bookCategoryLabel.text = @"图书类型";
    self.bookCategoryLabel.layer.borderWidth = 0.5;
    self.bookCategoryLabel.userInteractionEnabled = YES;
    //新建手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCategoryGesture:)];
    [self.bookCategoryLabel addGestureRecognizer:tapGesture];
    [self.view addSubview:self.bookCategoryLabel];
    [tapGesture release],tapGesture = nil;
    
    //书名
    self.bookNameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(135,79,180, 40)] autorelease];
    self.bookNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.bookNameTextField];
    
    //价格
    self.bookPriceTextField = [[[UITextField alloc] initWithFrame:CGRectMake(135, 169,130,40)] autorelease];
    self.bookPriceTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.bookPriceTextField];
    
#warning 测试数据
    
    //TODO:测试数据
    
//    self.bookCategoryLabel.text = @"数据库";
//    self.bookNameTextField.text = @"OC编程入门";
//    self.bookPriceTextField.text = @"78.3";
    


}
#pragma mark -实现手势方法:使用模态视图presentViewController: animated: completion:-
-(void)handleTapCategoryGesture:(UIGestureRecognizer *)sender{

    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    
    UINavigationController *categoryNC = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    [self.navigationController presentViewController:categoryNC animated:YES completion:nil];
    
    [categoryNC release],categoryNC = nil;
    [categoryVC release],categoryVC = nil;


}


#pragma mark--视图初始化区--
-(void)_initViewBaseComponents{
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(handleCancelAction:) ];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [leftBarButtonItem release],leftBarButtonItem = nil;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(handleDidAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem release],rightBarButtonItem = nil;
    
    
}
#pragma mark--点击事件的响应区--
//实现取消返回按钮
-(void)handleCancelAction:(UIBarButtonItem *)sender{
    
    //模态视图需要调用该方法
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//实现完成按钮功能
-(void)handleDidAction:(UIBarButtonItem *)sender{
    
    
    self.bookCategoryLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Category"];
    [[NSUserDefaults standardUserDefaults] objectForKey:@"firstCategory"];
    //插入数据
    BookInfo *newBookInfo = [[BookInfo alloc] initWithBookID:(arc4random()%55555) bookName:self.bookNameTextField.text bookPrice:self.bookPriceTextField.text bookCategory:self.bookCategoryLabel.text bookAvatar:[UIImage imageNamed:@"hihi.png"]];
    [DataBaseManager insertOneBookItemWithBooKInfo:newBookInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [newBookInfo release],newBookInfo = nil;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
