//
//  BookTrashViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookTrashViewController.h"
#import "BookItemCell.h"
#import "TrashDetailViewController.h"
#import "BookInfo.h"
#import "DataBaseManager.h"

@interface BookTrashViewController ()


@end

@implementation BookTrashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = @"回收站";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.bookItemListArray = [DataBaseManager findAllBookItemInfo:NO];
    [self.tableView reloadData];

    [[self.navigationController.view.superview.subviews lastObject] setHidden:NO];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    [self _initTableView];
    
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
#warning 测试数据
    
    
    return self.bookItemListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 测试数据
    
    static NSString *CellIndentifier = @"cell";
    
    BookItemCell *cell = (BookItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell == nil) {
        
        cell = [[[BookItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BookInfo *show = [self.bookItemListArray objectAtIndex:indexPath.row];
    
    cell.bookNameLabel.text = show.bookName;
    cell.bookPriceLabel.text = show.bookPrice;
    cell.bookCatagoryLabel.text = show.bookCategory;
    cell.bookAvatarImageView.image = [UIImage imageNamed:@"hihi.png"];
    
    return cell;
    
}

#pragma mark----实现协议方法-----

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //通过判断当前视图的父视图是NaviagtionController
    NSLog(@"-----%@",self.view.superview.subviews);
    [[self.navigationController.view.superview.subviews lastObject] setHidden:YES];

    TrashDetailViewController *trashBook = [[TrashDetailViewController alloc] init];
    //传递值
    trashBook.trashBookDetail = [self.bookItemListArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:trashBook animated:YES];
    [trashBook release],trashBook = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_bookItemListArray release];
    [_tableView release];
    [super dealloc];
}

@end
