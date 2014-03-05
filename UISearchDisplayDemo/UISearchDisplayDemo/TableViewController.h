//
//  TableViewController.h
//  UISearchDisplayDemo
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

//数据相关
@property(nonatomic,retain)NSDictionary *colorListDictionary;
@property(nonatomic,retain)NSArray *filterColorArray;//搜索结果
//@property(nonatomic,retain)NSMutableArray *colorNameListArray;

//搜索相关
@property(nonatomic,retain)UISearchBar *searchBar;
@property(nonatomic,retain)UISearchDisplayController *searchBarDisplay;


@end
