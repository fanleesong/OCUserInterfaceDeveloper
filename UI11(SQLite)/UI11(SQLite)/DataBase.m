//
//  DataBase.m
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

static sqlite3 *dataBasePoniter = nil;

+(sqlite3 *)openDataBase{
    
    if (dataBasePoniter == nil) {
        //获取文件路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //生成数据文件的文件存储路径
        NSString *dataBaseFilePath = [documentPath stringByAppendingPathComponent:@"Contact.sqlite"];
        //利用文件工具完成拷贝工作
        //判断数据库文件存储路径如果不存在，没有指定的.sqlite文件，在做拷贝
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:dataBaseFilePath]) {
            
            //生成应用程序包中原始SQLite文件路径
            NSString *sqlOrignlaFilePath = [[NSBundle mainBundle] pathForResource:@"Contact" ofType:@".sqlite"];
            //声明错误信息
            NSError *error = nil;
            //执行拷贝文件操作，将原始数据库文件拷贝到指定文件路径
            [fileManager copyItemAtPath:sqlOrignlaFilePath toPath:dataBaseFilePath error:&error];
            
            if (error != nil) {
                NSLog(@"%@",[error description]);
                //如果拷贝出错，打印错误信息
                return nil;
            }
        }
        //一旦拷贝成功，就通过沙盒路径下的SQL文件执行打开数据库的操作
        sqlite3_open([dataBaseFilePath UTF8String], &dataBasePoniter);
    }
    
    return dataBasePoniter;

}

//关闭数据库
+(void)closeDataBase{

    if (dataBasePoniter !=nil) {
        sqlite3_close(dataBasePoniter);
    }


}












@end
