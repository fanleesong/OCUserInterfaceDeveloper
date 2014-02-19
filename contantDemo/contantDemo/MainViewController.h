//
//  MainViewController.h
//  contantDemo
//
//  Created by 范林松 on 14-2-17.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
//添加相关协议方法
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DetailViewDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)UITableView *contactTableView;
//战士联系人列表视图
//数据源数组，中间量，联系人基本信息以对象形式存储在数组中，在通过tableView显示
@property(nonatomic,retain)NSMutableArray *contactLListArray;

@end
