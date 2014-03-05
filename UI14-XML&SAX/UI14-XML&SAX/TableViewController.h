//
//  TableViewController.h
//  UI14-XML&SAX
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Students.h"


@interface TableViewController : UITableViewController<NSXMLParserDelegate>//引入xml解析协议

@property(nonatomic,retain)NSMutableArray *stuArray;

//读取XML文件，将其转换为NSData文件格式
-(NSData *)loadFile;


@end
