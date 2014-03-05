//
//  BookDetailViewController.m
//  BookManager
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
-(void)dealloc{

    [_books release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //添加编辑按钮
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"书籍详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBookInfoAction:)];
    
    //实例化相关显示界面
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,124, 60, 60)];
    imageView.image = [UIImage imageNamed:@"hihi.png"];
    [self.view addSubview:imageView];
    [imageView release],imageView = nil;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 124, 210, 25)];
    nameLabel.textAlignment =   NSTextAlignmentCenter;
    nameLabel.text = self.books.bookName;
    [self.view addSubview:nameLabel];
    [nameLabel release],nameLabel = nil;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 159, 90, 25)];
    priceLabel.textAlignment =   NSTextAlignmentCenter;
    priceLabel.text = [NSString stringWithFormat:@"%.2f",self.books.bookPrice];
    [self.view addSubview:priceLabel];
    [priceLabel release],priceLabel = nil;

    
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 159, 110, 25)];
    typeLabel.textAlignment =   NSTextAlignmentCenter;
    typeLabel.text = self.books.typeName;
    [self.view addSubview:typeLabel];
    [typeLabel release],typeLabel = nil;
    

    
    
    
    
    
    
    
    
    
}
#pragma mark -实现editBookInfoAction 编辑方法-
-(void)editBookInfoAction:(UIBarButtonItem *)sender{




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
