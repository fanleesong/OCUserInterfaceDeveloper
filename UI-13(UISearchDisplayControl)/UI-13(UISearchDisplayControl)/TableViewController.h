//
//  TableViewController.h
//  UI-13(UISearchDisplayControl)
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController<UISearchDisplayDelegate>

@property (nonatomic,retain)NSMutableArray *listArray;
@property (nonatomic,retain)UISearchBar *searchBar;
@property (nonatomic,retain)UISearchDisplayController *searchDisplay;

@end
