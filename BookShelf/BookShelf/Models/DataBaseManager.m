//
//  DataBaseManager.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

static FMDatabase *dataBase = nil;

+(FMDatabase *)openDataBase{


    NSString *dataBasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"bookInfo.sqlite"];
    
    //通过指定文件路径实例化FMData对象
    //如果不存在bookInfo.sqlitewen文件，会自动实例化一个bookInfo.sqlite数据库文件
    dataBase = [FMDatabase databaseWithPath:dataBasePath];
    
    NSLog(@"%@",dataBasePath);
    
    if ([dataBase open]) {
        
        [dataBase executeUpdate:@"create table if not exists bookInfo(bookId integer primary key AUTOINCREMENT,bookName text,bookPrice text,bookCategory text,bookAvatar blob,isShow Bool)"];
        
        return dataBase;
        
    }else{
    
        return Nil;
    
    }
    
    
    
}
+(void)closeDataBase{

        [dataBase close];
    
}

+(NSMutableArray *)findAllBookItemInfo:(NSString *)category isShow:(BOOL)isShow{
    
    NSMutableArray *bookInfoArray = [NSMutableArray array];
    //打开数据库
    FMDatabase *oneDataBase = [DataBaseManager openDataBase];
    //
    FMResultSet *resultSet = [oneDataBase executeQuery:[NSString stringWithFormat:@"select * from bookinfo where isShow=%d and bookCategory='%@'",YES,category]];
    
    while ([resultSet next]) {
        
        NSInteger bookId = [resultSet intForColumn:@"bookId"];
        NSString *bookName = [resultSet stringForColumn:@"bookName"];
        NSString *bookPrice = [resultSet stringForColumn:@"bookPrice"];
        NSString *bookCategory = [resultSet stringForColumn:@"bookCategory"];
        NSData *bookAvatar = [resultSet dataForColumn:@"bookAvatar"];
        
        BookInfo *book = [[BookInfo alloc] initWithBookID:bookId bookName:bookName bookPrice:bookPrice bookCategory:bookCategory bookAvatar:[UIImage imageWithData:bookAvatar]];
        [bookInfoArray addObject:book];
        [book release],book = nil;
        
    }
    
    [DataBaseManager closeDataBase];
    
    
    return bookInfoArray;

}

//查询
+(NSMutableArray *)findAllBookItemInfo:(BOOL)isShow{

    NSMutableArray *bookInfoArray = [NSMutableArray array];
    //打开数据库
    FMDatabase *oneDataBase = [DataBaseManager openDataBase];
    //
    FMResultSet *resultSet = [oneDataBase executeQuery:[NSString stringWithFormat:@"select * from bookinfo where isShow=%d",isShow]];
    
    while ([resultSet next]) {

        NSInteger bookId = [resultSet intForColumn:@"bookId"];
        NSString *bookName = [resultSet stringForColumn:@"bookName"];
        NSString *bookPrice = [resultSet stringForColumn:@"bookPrice"];
        NSString *bookCategory = [resultSet stringForColumn:@"bookCategory"];
        NSData *bookAvatar = [resultSet dataForColumn:@"bookAvatar"];
        
        BookInfo *book = [[BookInfo alloc] initWithBookID:bookId bookName:bookName bookPrice:bookPrice bookCategory:bookCategory bookAvatar:[UIImage imageWithData:bookAvatar]];
        [bookInfoArray addObject:book];
        [book release],book = nil;
        
    }
    
    [DataBaseManager closeDataBase];


    return bookInfoArray;
}
+(BOOL)insertOneBookItemWithBooKInfo:(BookInfo *)bookItemInf{

     FMDatabase *oneDataBase = [DataBaseManager openDataBase];
    NSLog(@"%@",oneDataBase);
     BOOL result = [oneDataBase executeUpdateWithFormat:@"insert into bookinfo values(%d,%@,%@,%@,%@,%d)",bookItemInf.bookID,bookItemInf.bookName,bookItemInf.bookPrice,bookItemInf.bookCategory,UIImagePNGRepresentation(bookItemInf.bookAvatar),1];
    NSLog(@"%d",result);
    
    [DataBaseManager closeDataBase];
    
    return result;

}
+(BOOL)updateOneBookItemWithBookInfo:(BookInfo *)bookItemInfo{

    FMDatabase *connection = [DataBaseManager openDataBase ];
    BOOL result = [connection executeUpdateWithFormat:@"update bookinfo set bookName=%@,bookPrice=%@,bookCategory=%@,bookAvatar=%@,isShow=%d where bookId=%d",bookItemInfo.bookName,bookItemInfo.bookPrice,bookItemInfo.bookCategory,UIImagePNGRepresentation(bookItemInfo.bookAvatar),bookItemInfo.isStatus,bookItemInfo.bookID];
    
    [DataBaseManager closeDataBase];
    
    return result;
}


+(BOOL)deleteOneBookItemWithBookInfo:(BookInfo *)bookItemInfo{

    FMDatabase *onedataBase = [DataBaseManager openDataBase];
    
    BOOL result = [onedataBase executeUpdateWithFormat:@"delete from bookinfo where bookId=%d",bookItemInfo.bookID];
    
    [DataBaseManager closeDataBase];
    
    return  result;
}



@end
