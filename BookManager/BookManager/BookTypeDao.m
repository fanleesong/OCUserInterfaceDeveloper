//
//  BookTypeDao.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookTypeDao.h"
#import "BookType.h"
#import "BaseDao.h"

@implementation BookTypeDao

+(NSMutableArray *)findAllBooksTypeInfo{

    NSMutableArray *bookArray = [NSMutableArray array];
    //打开数据数据库
    sqlite3 *dataBase = [BaseDao openDataBase];
    //新建
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(dataBase, " select * from booktype;", -1, &stmt, nil);
    
    //    NSLog(@"%d",result);
    
    if (result == SQLITE_OK) {
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            
            BookType *books = [[BookType alloc] init];
            books.typeId = sqlite3_column_int(stmt, 0);
            books.typeName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            books.remark = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            //添加数据集合
            [bookArray addObject:books];
            [books release],books = nil;
        }
        
    }
    //关闭stamt
    sqlite3_finalize(stmt);
    //关闭数据库
    [BaseDao closeDataBase];
    
    
    return bookArray;

}

+(BookType *)findBookTypeById:(int)bookTypeid{
    //声明
    BookType *bookType = [[BookType alloc] init];

    //打开数据库
    
    sqlite3 *dataBase = [BaseDao openDataBase];
    
    //
    sqlite3_stmt *statement = nil;
    
    if (sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@"select * from booktype where typeid = %d",bookTypeid] UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int typeid = sqlite3_column_int(statement, 0);
            const unsigned char *typename = sqlite3_column_text(statement,1);
            const unsigned char *remark = sqlite3_column_text(statement, 2);
            
            bookType.typeId = typeid;
            bookType.typeName = [NSString stringWithUTF8String:(const char *)typename];
            bookType.remark = [NSString stringWithUTF8String:(const char *)remark];
            [bookType release],bookType = nil;
        }
        
    }
    sqlite3_finalize(statement);
    [BaseDao closeDataBase];

    return bookType;

}

@end
