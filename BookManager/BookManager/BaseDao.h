//
//  BaseDao.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDao : NSObject

+(sqlite3 *)openDataBase;
+(void)closeDataBase;

@end
