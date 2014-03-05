//
//  BaseDao.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BaseDao.h"

static sqlite3 *dataBasePointer = nil;

@implementation BaseDao

+(sqlite3 *)openDataBase{
    
    if (dataBasePointer == nil) {
        //查找沙盒中的数据库文件
        NSString *bundlePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"bookSys.sqlite"];
//        NSLog(@"%@",bundlePath);
        //判断沙盒中是否有该数据库文件
        if (![[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
            NSLog(@"%@",bundlePath);
           //获取工程文件
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bookSys" ofType:@".sqlite"];
            //复制文件
            [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:bundlePath error:nil];
            //打开数据库
            
        }
       sqlite3_open([bundlePath UTF8String], &dataBasePointer); 
    }

    return dataBasePointer;
}

+(void)closeDataBase{

    if (dataBasePointer !=nil) {
        sqlite3_close(dataBasePointer);
        dataBasePointer = nil;
    }

}
@end
