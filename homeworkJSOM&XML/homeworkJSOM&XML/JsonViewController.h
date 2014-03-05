//
//  JsonViewController.h
//  homeworkJSOM&XML
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsonViewController : UITableViewController<NSURLConnectionDataDelegate>

@property(nonatomic,retain)NSMutableData *showData;
@property(nonatomic,retain)NSDictionary *dataDictionary;
@property(nonatomic,retain)NSMutableArray *locationArray;

@end
