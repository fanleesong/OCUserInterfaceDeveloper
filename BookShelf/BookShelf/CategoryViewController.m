//
//  CategoryViewController.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
-(void)dealloc{

    [_categoryListArray release];
    [_tableView release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"书籍分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //调用视图初始化的方法
    [self _initViewBaseComponents];
    //调用初始化视图及数组方法
    [self _initTableViewAndCategoryArray];
    
    
}
#pragma mark--初始化tableView--
-(void)_initTableViewAndCategoryArray{
    
    //初始化视图
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.rowHeight = 30;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //初始化数组
    self.categoryListArray = [NSMutableArray array];
    [self.categoryListArray addObjectsFromArray:@[@"全部",@"数据库",@"编程语言",@"图形图形",@"网页制作",@"办公软件",@"计算机与互联网",@"世界史"]];
    
}
#pragma mark-实现代理方法-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.categoryListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIndentfier = @"CELLCategory";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentfier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentfier] autorelease];
        
    }
    cell.textLabel.text = [self.categoryListArray objectAtIndex:indexPath.row];
    
    return cell;

}
//选中单元格方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取所选行，并设置acessary
    ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).accessoryType = UITableViewCellAccessoryCheckmark;

}
//选中下一个单元格时，之前被选中的单元格会返回到初始状态
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取所选行，并设置acessary
    ((UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).accessoryType = UITableViewCellAccessoryNone;

}

#pragma mark--一些视图初始化区--
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





}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
