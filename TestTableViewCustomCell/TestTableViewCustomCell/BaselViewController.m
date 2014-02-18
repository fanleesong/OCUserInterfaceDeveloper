//
//  BaselViewController.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaselViewController.h"
#import "BaseCell.h"
#import "BaseModel.h"
#import "CellFactory.h"

@interface BaselViewController ()

@end

@implementation BaselViewController

- (void)dealloc
{
    [_tableView release];
    [_dataArray release];
    [super dealloc];
}

- (NSMutableArray *)hardCode{
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataArray = [[self hardCode] retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    //    [_tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];
    //    [_tableView registerClass:[MyCell2 class] forCellReuseIdentifier:@"cell2"];
    
    [self.navigationItem setRightBarButtonItem:self.editButtonItem];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark tableView datasource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
    //    return 100000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取对应行的model对象
    BaseModel *userInfo = [_dataArray objectAtIndex:indexPath.row];
    //    static NSString *cellIdentifier = @"cell";
    //    static NSString *cellIdentifier2 = @"cell2";
    //    BaseCell *cell = nil;
    //    if (indexPath.row % 2 == 0) {
    //        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    }else{
    //        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    //    }
    //获取model对应的cell类
    Class cellClass = [CellFactory cellClassForModel:userInfo];
    //以类名做标识符取可重用的cell
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class])];
    if (!cell) {
        //在类名做重用标识符,以model对应的cell类创建新的cell
        cell = [CellFactory cellForModel:userInfo reuseIdentifier:NSStringFromClass([cellClass class])];
    }
    [cell setDataForCell:userInfo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseModel *model = [_dataArray objectAtIndex:indexPath.row];
    //    Class cellClass = [CellFactory cellClassForModel:model];
    Class cellClass = cellClassForModel(model);
    CGFloat height = [cellClass cellHeightForModel:model];
    
    return height;
}

@end
