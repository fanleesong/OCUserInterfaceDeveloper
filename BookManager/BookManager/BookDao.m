//
//  BookDao.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookDao.h"
#import "BaseDao.h"
#import "Books.h"

@implementation BookDao

+(NSMutableArray *)findAllBooksInfo{

    NSMutableArray *bookArray = [NSMutableArray array];
    //打开数据数据库
    sqlite3 *dataBase = [BaseDao openDataBase];
    //新建
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(dataBase, " select * from bookInfo;", -1, &stmt, nil);
    
    if (result == SQLITE_OK) {

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            Books *books = [[Books alloc] init];
            books.bookId = sqlite3_column_int(stmt, 0);
            books.bookName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt,1)];
            books.bookPrice =sqlite3_column_double(stmt, 3);
            books.typeId = sqlite3_column_int(stmt, 4);
            books.typeName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            books.isDelete = sqlite3_column_int(stmt, 6);
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
//根据其是否删除的状态，查询在回收站中
+(NSMutableArray *)findBookByStatus:(int)isDelete{

    NSMutableArray *bookArray = [NSMutableArray array];
    //打开数据数据库
    sqlite3 *dataBase = [BaseDao openDataBase];
    //新建
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@ "select * from bookInfo where isDelete =%d",isDelete] UTF8String], -1, &stmt, nil);
    
    if (result == SQLITE_OK) {
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            Books *books = [[Books alloc] init];
            books.bookId = sqlite3_column_int(stmt, 0);
            books.bookName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt,1)];
            books.bookPrice =sqlite3_column_double(stmt, 3);
            books.typeId = sqlite3_column_int(stmt, 4);
            books.typeName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            books.isDelete = sqlite3_column_int(stmt, 6);
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

+(BOOL)updateBookById:(Books *)bookInfo{
    
    sqlite3 *dataBase = [BaseDao openDataBase];
    sqlite3_stmt *statements = nil;
    NSLog(@"8989898989");
    int result = sqlite3_prepare_v2(dataBase, "update bookInfo set isDelete=? where bookid=?;", -1, &statements, nil) ;
    NSLog(@"%d",result);
    if (result == SQLITE_OK) {
        
        NSLog(@"uiuiuiuiuiui");
        sqlite3_bind_int(statements, 1, bookInfo.isDelete);
//        sqlite3_bind_text(statements, 2, [bookInfo.bookName UTF8String], -1, nil);
//        sqlite3_bind_text(statements, 3, [bookInfo.bookPage UTF8String], -1, nil);
//        sqlite3_bind_double(statements, 4, bookInfo.bookPrice);
//        sqlite3_bind_int(statements, 5, bookInfo.typeId);
//        sqlite3_bind_text(statements, 6, [bookInfo.typeName UTF8String], -1, nil);
        sqlite3_bind_int(statements, 2, bookInfo.bookId);
        
        if (sqlite3_step(statements) == SQLITE_DONE) {
            sqlite3_finalize(statements);
            [BaseDao closeDataBase];
            return YES;
        }

    }
    sqlite3_finalize(statements);
    [BaseDao closeDataBase];

    return NO;
}

+(BOOL)deleteBookById:(Books *)bookInfo{
    
    sqlite3 *dataBase = [BaseDao openDataBase];
    
    sqlite3_stmt *statement = nil;
    if (sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@"delete from bookinfo where bookid=%d",bookInfo.bookId] UTF8String],-1, &statement, nil) == SQLITE_OK) {
        
        if(sqlite3_step(statement)==SQLITE_DONE){
            sqlite3_finalize(statement);
            [BaseDao closeDataBase];
            return YES;
        }
        
    }
    
    sqlite3_finalize(statement);
    [BaseDao closeDataBase];

    return NO;
}
//批量删除
+(BOOL)deleteAllBookByIds:(NSMutableArray *)IdsArray{
    
    sqlite3 *dataBase = [BaseDao openDataBase];
    
    sqlite3_stmt *statement = nil;


    for (int i=0; i< IdsArray.count; i++) {
        
        if (sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@"delete from bookinfo where bookid=%@",[IdsArray objectAtIndex:i]] UTF8String],-1, &statement, nil) == SQLITE_OK) {
            
            if(sqlite3_step(statement)==SQLITE_DONE){
                sqlite3_finalize(statement);
                [BaseDao closeDataBase];
                return YES;
            }
            
        }

    }
    
    sqlite3_finalize(statement);
    [BaseDao closeDataBase];
    
    return NO;
}
+(BOOL)saveBookInfo:(Books *)bookInfo{
    
    sqlite3 *dataBase = [BaseDao openDataBase];
    sqlite3_stmt *statements = nil;
    if (sqlite3_exec(dataBase, "insert into bookInfo values(?,?,?,?,?,?,?);", nil, nil, nil) == SQLITE_OK) {
        sqlite3_bind_int(statements, 1, bookInfo.bookId);
        sqlite3_bind_text(statements, 2, [bookInfo.bookName UTF8String], -1, nil);
        sqlite3_bind_text(statements, 3, [bookInfo.bookPage UTF8String], -1, nil);
        sqlite3_bind_double(statements, 4, bookInfo.bookPrice);
        sqlite3_bind_int(statements, 5, bookInfo.typeId);
        sqlite3_bind_text(statements, 6, [bookInfo.typeName UTF8String], -1, nil);
        sqlite3_bind_int(statements, 7, bookInfo.isDelete);
        
        if (sqlite3_step(statements) == SQLITE_DONE) {
            sqlite3_finalize(statements);
            [BaseDao closeDataBase];
            return YES;
        }

    }
    sqlite3_finalize(statements);
    [BaseDao closeDataBase];
    
    return NO;

}




@end
