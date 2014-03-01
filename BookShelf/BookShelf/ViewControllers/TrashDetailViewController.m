//
//  TrashDetailViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "TrashDetailViewController.h"
#import "DataBaseManager.h"

@interface TrashDetailViewController ()

@property (nonatomic,retain) UITextField *bookNameTextField;
@property (nonatomic,retain) UILabel *bookCategoryLabel;
@property (nonatomic,retain) UITextField *bookPriceTextField;


@end

@implementation TrashDetailViewController

-(void)dealloc{
    
    [_bookCategoryLabel release];
    [_bookPriceTextField release];
    [_bookNameTextField release];
    [_trashBookDetail release];
    
    [super dealloc];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"回收站详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initSomeProperty];
}

//实例化属性
-(void)_initSomeProperty{
    
    
    //图片
    UIImageView *bookAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 74,100 ,100 )];
    bookAvatar.image = self.trashBookDetail.bookAvatar
    ;
    [self.view addSubview:bookAvatar];
    [bookAvatar release],bookAvatar = nil;
    
    //类别
    self.bookCategoryLabel = [[[UILabel alloc] initWithFrame:CGRectMake(135, 124, 180,40)] autorelease];
    self.bookCategoryLabel.layer.borderWidth = 0.5;
    self.bookCategoryLabel.userInteractionEnabled = NO;
    [self.view addSubview:self.bookCategoryLabel];
    
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
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(40, 230,240, 50);
    undoButton.backgroundColor = [UIColor blueColor];
    [undoButton setTitle:@"放回书架" forState:UIControlStateNormal];
    [undoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [undoButton addTarget:self action:@selector(undoBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:undoButton];
    
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    delButton.frame = CGRectMake(40, 320, 240, 50);
    delButton.backgroundColor = [UIColor redColor];
    [delButton setTitle:@"彻底删除书籍" forState:UIControlStateNormal];
    [delButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(deleteBookAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delButton];

    
#warning 测试数据
    
    //TODO:测试数据
    
    self.bookCategoryLabel.text = self.trashBookDetail.bookCategory;
    self.bookNameTextField.text = self.trashBookDetail.bookName;
    self.bookPriceTextField.text = self.trashBookDetail.bookPrice;
    
    
    
}
#pragma mark-undoBackAction-
-(void)undoBackAction:(UIButton *)sender{
    NSLog(@"%s",__FUNCTION__);
    //放回书架
    self.trashBookDetail.isStatus = YES;
    [DataBaseManager updateOneBookItemWithBookInfo:self.trashBookDetail];
    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void)deleteBookAction:(UIButton *)sender{
    //彻底删除
    [DataBaseManager deleteOneBookItemWithBookInfo:self.trashBookDetail];
    [self.navigationController popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
