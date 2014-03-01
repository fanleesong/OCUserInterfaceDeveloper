//
//  BookDetailViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookDetailViewController.h"
#import "CategoryViewController.h"
#import "DataBaseManager.h"

@interface BookDetailViewController ()

@property (nonatomic,retain) UITextField *bookNameTextField;
@property (nonatomic,retain) UILabel *bookCategoryLabel;
@property (nonatomic,retain) UITextField *bookPriceTextField;

@end

@implementation BookDetailViewController

-(void)dealloc{
    
    [_bookCategoryLabel release];
    [_bookPriceTextField release];
    [_bookNameTextField release];
    [_bookDetailInfo release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"书籍详情";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if (self.editing) {
        self.bookCategoryLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Category"];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //使用系统自带编辑按钮方法并重写其方法
    //)setEditing:editing animated:
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self _initSomeProperty];
}

//实现系统自带编辑方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{

    [super setEditing:editing animated:animated];
    
    if (editing) {
//self.bookCategoryLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Category"];
        self.bookPriceTextField.userInteractionEnabled = YES;
        self.bookNameTextField.userInteractionEnabled = YES;
        self.bookCategoryLabel.userInteractionEnabled = YES;
        //添加书籍名称变为第一响应者
        [self.bookNameTextField becomeFirstResponder];
        
    }else{

//        self.bookCategoryLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"Category"];
        //获取最新编辑数据
        self.bookDetailInfo.bookName = self.bookNameTextField.text;
        self.bookDetailInfo.bookPrice  = self.bookPriceTextField.text;
        self.bookDetailInfo.bookCategory = self.bookCategoryLabel.text;
        //更新数据库
        [DataBaseManager updateOneBookItemWithBookInfo:self.bookDetailInfo];
        self.bookPriceTextField.userInteractionEnabled = NO;
        self.bookNameTextField.userInteractionEnabled = NO;
        self.bookCategoryLabel.userInteractionEnabled = NO;
    
    }

}


//实例化属性
-(void)_initSomeProperty{
    
    
    //图片
    UIImageView *bookAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 74,100 ,100 )];
    bookAvatar.image = self.bookDetailInfo.bookAvatar;
    [self.view addSubview:bookAvatar];
    [bookAvatar release],bookAvatar = nil;
    
    //类别
    self.bookCategoryLabel = [[[UILabel alloc] initWithFrame:CGRectMake(135, 124, 180,40)] autorelease];
    self.bookCategoryLabel.text = @"图书类型";
    self.bookCategoryLabel.layer.borderWidth = 0.5;
    self.bookCategoryLabel.userInteractionEnabled = NO;
    //新建手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCategoryGesture:)];
    [self.bookCategoryLabel addGestureRecognizer:tapGesture];
    [self.view addSubview:self.bookCategoryLabel];
    [tapGesture release],tapGesture = nil;
    
    //书名
    self.bookNameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(135,79,180, 40)] autorelease];
    self.bookNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.bookNameTextField.userInteractionEnabled = NO;
    [self.view addSubview:self.bookNameTextField];
    
    //价格
    self.bookPriceTextField = [[[UITextField alloc] initWithFrame:CGRectMake(135, 169,130,40)] autorelease];
    self.bookPriceTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.bookPriceTextField.userInteractionEnabled = NO;
    [self.view addSubview:self.bookPriceTextField];
    
    self.bookCategoryLabel.text = self.bookDetailInfo.bookCategory;
    self.bookNameTextField.text = self.bookDetailInfo.bookName;
    self.bookPriceTextField.text = self.bookDetailInfo.bookPrice;
    
    
    
}
#pragma mark -实现手势方法:使用模态视图presentViewController: animated: completion:-
-(void)handleTapCategoryGesture:(UIGestureRecognizer *)sender{
    
    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    
    UINavigationController *categoryNC = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    [self.navigationController presentViewController:categoryNC animated:YES completion:nil];
    
    [categoryNC release],categoryNC = nil;
    [categoryVC release],categoryVC = nil;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
