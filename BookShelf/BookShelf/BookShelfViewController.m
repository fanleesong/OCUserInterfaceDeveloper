//
//  BookShelfViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.

#import "BookShelfViewController.h"
#import "CategoryViewController.h"
#import "AddBookViewController.h"
#import "BookDetailViewController.h"
#import "BookTrashViewController.h"
#import "BookItemCell.h"
#import "DataBaseManager.h"

@interface BookShelfViewController ()
{
    BookTrashViewController *_trashVC;
    UINavigationController *_rootVC;
}
@end

@implementation BookShelfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"书架";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSString *Category = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstCategory"];
    if ([Category isEqualToString:@"全部"] || Category == nil) {
        
        //显示书架书籍
        self.bookItemListArray  = [DataBaseManager findAllBookItemInfo:YES];

    }else{
    
        //显示书架书籍
        self.bookItemListArray  = [DataBaseManager findAllBookItemInfo:Category isShow:YES];

    }
    
    
    [self.tableView reloadData];

}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //调用初始化barbutton方法
    [self _initBarButton];
    //调用实例化标示图
    [self _initTableView];
    //调用toolbar方法
    [self _initToolBar];
    
    [DataBaseManager openDataBase];
    
    [DataBaseManager insertOneBookItemWithBooKInfo:[[BookInfo alloc] initWithBookID:78 bookName:@"C语言教程(第一版)" bookPrice:@"23" bookCategory:@"数据库" bookAvatar:[UIImage imageNamed:@"hihi.png"]]];
    
    
    
}
#pragma mark--初始化一些属性tableView--
-(void)_initTableView{

    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height -44) style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 66;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}
#pragma mark--实现代理方法 dataSource & delegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.bookItemListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIndentifier = @"cell";
    
    BookItemCell *cell = (BookItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell == nil) {
        
        cell = [[[BookItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BookInfo *books = [self.bookItemListArray objectAtIndex:indexPath.row];
//    NSLog(@"%@",books);
    cell.bookNameLabel.text = books.bookName;
    cell.bookPriceLabel.text = books.bookPrice;
    cell.bookCatagoryLabel.text = books.bookCategory;
    cell.bookAvatarImageView.image = books.bookAvatar;
    
    
//    cell.bookNameLabel.text = @"C语言基础教程第一版";
//    cell.bookPriceLabel.text = @"78.9";
//    cell.bookCatagoryLabel.text =@"计算机与科学";
//    cell.bookAvatarImageView.image = [UIImage imageNamed:@"hihi.png"];
    
    
    return cell;

}


#pragma mark--初始化视图相关区--
//实例化工具条
-(void)_initToolBar{
    //书架
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -44, 320, 44)];
    UIBarButtonItem *leftToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(handleBookShelf:)];
    //空间空格
    UIBarButtonItem *spaceToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //回收站按钮
    UIBarButtonItem *rightToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(handleTrashViewController:)];
    
    toolBar.items = @[leftToolBarItem,spaceToolBarItem,rightToolBarItem];
    
    [self.view addSubview:toolBar];
    [leftToolBarItem release],leftToolBarItem = nil;
    [spaceToolBarItem release],spaceToolBarItem = nil;
    [rightToolBarItem release],rightToolBarItem = nil;
    [toolBar release],toolBar = nil;
    
    
    
}
//实例化导航栏视图按钮
-(void)_initBarButton{

    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    categoryButton.frame = CGRectMake(0, 0, 40, 35);
    [categoryButton setTitle:@"分类" forState:UIControlStateNormal];
    [categoryButton addTarget:self action:@selector(handlePushCategroyViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:categoryButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [leftBarButtonItem release], leftBarButtonItem = nil;
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddBookAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem release],rightBarButtonItem = nil;
}
#pragma mark-实现协议方法-
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BookDetailViewController *detail = [[BookDetailViewController alloc] init];
    detail.bookDetailInfo = [self.bookItemListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release],detail = nil;

}


#pragma mark--点击事件处理区--

//实现点击分类按钮
-(void)handlePushCategroyViewController:(UIButton *)sender{
    
    //实例化分类视图控制器
    CategoryViewController *category = [[CategoryViewController alloc] init];
    
    category.isWhichMark = 1;
    
    //实例化导航视图
    UINavigationController *navigationByCategory = [[UINavigationController alloc] initWithRootViewController:category];
    //调用presentViewController:animated:completion:方法，就是模态视图
    //作用：在一个视图控制器上呈现另一个视图控制器，通常用在2个视图控制器之间没有明显的层级关系时
    [self.navigationController presentViewController:navigationByCategory animated:YES completion:nil];
    [category release],category = nil;
    [navigationByCategory release],navigationByCategory = nil;
    
    
    
    
}
//实现添加书籍按钮功能
-(void)handleAddBookAction:(UIBarButtonItem *)sender{
    
    //初始化添加书籍视图
    AddBookViewController *addBook = [[AddBookViewController alloc] init];
    UINavigationController *naAdd = [[UINavigationController alloc] initWithRootViewController:addBook];
    naAdd.modalPresentationStyle  = UIModalPresentationPageSheet;
    [self.navigationController presentViewController:naAdd animated:YES completion:nil];
    [addBook release],addBook = nil;
    [naAdd release],naAdd = nil;


}
//实例化书架按钮
-(void)handleBookShelf:(UIBarButtonItem *)sender{

    //隐藏导航视图器的导航条
    self.navigationController.navigationBarHidden = NO;
    //移除
    [[self.view viewWithTag:120] removeFromSuperview];
    //切换到书架时在对该导航控制器释放
    [_rootVC release],_rootVC = nil;
    
//TODO:待完善
    
    NSString *Category = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstCategory"];
    if ([Category isEqualToString:@"全部"] || Category == nil) {
        
        //显示书架书籍
        self.bookItemListArray  = [DataBaseManager findAllBookItemInfo:YES];
        
    }else{
        
        //显示书架书籍
        self.bookItemListArray  = [DataBaseManager findAllBookItemInfo:Category isShow:YES];
        
    }
    
    [self.tableView reloadData];


}
//实例化点击toolbar的垃圾站
-(void)handleTrashViewController:(UIBarButtonItem *)sender{
    
    
    if (!self.navigationController.navigationBarHidden) {
        
        //隐藏导航视图器的导航条
        self.navigationController.navigationBarHidden = YES;
        //实例化垃圾站视图
        _trashVC = [[BookTrashViewController alloc] init];//retainCount = 1
        //实例化导航视图
        _rootVC = [[UINavigationController alloc] initWithRootViewController:_trashVC];//retainCount = 1,此时 trash-->retainCount +1
        _rootVC.view.tag =120;
        
        //使用插入视图方法，在原有视图上覆盖新的视图
        [self.view insertSubview:_rootVC.view belowSubview:[self.view.subviews lastObject]];
        //插入的是导航控制器管理的视图，并非导航控制本身
        
        
//        [trash release],trash = nil;//trash--> retainCount = 1
//        [rootVC release],rootVC = nil;//retainCount = 0 --->调用自身的dealloc方法,同时会对trash执行一次release操作，导致trash调用自身的dealloc方法
        
        
    }



}
#pragma mark-实现编辑单元格代理方法-
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{


    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        BookInfo *isShowBook = [self.bookItemListArray objectAtIndex:indexPath.row];
        isShowBook.isStatus = NO;
        [DataBaseManager updateOneBookItemWithBookInfo:isShowBook];
        [self.bookItemListArray removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    [_tableView release];
    [_bookItemListArray release];
    [super dealloc];
}






@end
