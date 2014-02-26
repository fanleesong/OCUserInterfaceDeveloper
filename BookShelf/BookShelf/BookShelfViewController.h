//
//  BookShelfViewController.h
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookShelfViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain) UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *bookItemListArray;

@end
