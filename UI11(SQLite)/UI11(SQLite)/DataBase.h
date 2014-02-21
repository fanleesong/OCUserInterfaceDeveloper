//
//  DataBase.h
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>//引入SQLite3

@interface DataBase : NSObject

+(sqlite3 *) openDataBase;//打开数据库
+(void)closeDataBase;//关闭数据库


@end
