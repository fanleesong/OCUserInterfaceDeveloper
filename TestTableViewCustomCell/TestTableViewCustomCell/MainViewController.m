//
//  MainViewController.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MainViewController.h"
#import "UserInfo.h"
#import "MyCell.h"
#import "UserInfo2.h"
#import "MyCell2.h"
#import "CellFactory.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)dealloc
{
    [_tableView release];
    [_dataArray release];
    [super dealloc];
}

- (NSMutableArray *)hardCode{
    UserInfo *u1 = [UserInfo userInfoWithName:@"robin" phoneNumber:@"1" imagePath:nil];
    UserInfo *u2 = [UserInfo userInfoWithName:@"zoro" phoneNumber:@"2@lanou3g.com" imagePath:nil];
    UserInfo *u3 = [UserInfo userInfoWithName:@"sogeking" phoneNumber:@"3" imagePath:nil];
    UserInfo *u4 = [UserInfo userInfoWithName:@"luffy" phoneNumber:@"4@lanou3g.com" imagePath:nil];
    UserInfo *u5 = [UserInfo userInfoWithName:@"nami" phoneNumber:@"5" imagePath:nil];
    UserInfo *u6 = [UserInfo userInfoWithName:@"sanji" phoneNumber:@"6@lanou3g.com" imagePath:nil];
    UserInfo *u7 = [UserInfo userInfoWithName:@"chopper" phoneNumber:@"7" imagePath:nil];
    UserInfo *u8 = [UserInfo userInfoWithName:@"frank" phoneNumber:@"8@lanou3g.com" imagePath:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:u1, u2, u3, u4, u5, u6, u7, u8, nil];
    
    int i = 1;
    for (UserInfo *userInfo in array) {
        NSString *imageName = [NSString stringWithFormat:@"h%d", i++];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpeg"];
        [userInfo setImagePath:imagePath];
    }
    
    return [[array retain] autorelease];
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
    
    for (UIView *aView in self.view.subviews) {
        [aView setBackgroundColor:[UIColor blackColor]];
    }
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
    UserInfo *userInfo = [_dataArray objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cell";

    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    [cell setDataForCell:userInfo];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
