//
//  ContactDao.m
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "ContactDao.h"
#import "ContactInfo.h"
#import "DataBase.h"


@implementation ContactDao

+(NSMutableArray *)selAllContactInfo{

    //打开数据库
    sqlite3 *dataBase = [DataBase openDataBase];
    //声明SQLite3_stmt指针
    sqlite3_stmt *statement = nil;
    //通过sqlite3_prepare_v2函数，检查SQL语句是否正确，如果正确将结果存入statement指针，如果错误返回错误信息
    //该函数拥有五个参数，需要明确提供给的参数为：数据库指针、SQL语句、statement指针地址，
    //其他两个整型的bytes指定为-1，最后一个指定为nil;
    int result = sqlite3_prepare_v2(dataBase, "select * from ContactInfo", -1, &statement, nil);
//
    NSMutableArray *contactlist = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            const unsigned char *name = sqlite3_column_text(statement, 0);
            const unsigned char *password = sqlite3_column_text(statement, 1);
            const unsigned char *number = sqlite3_column_text(statement, 2);
            //将C语言中的字符数组，转成OCNSString类型的实例对象
            NSString *contactName = [NSString stringWithUTF8String:(const char *)name];
            NSString *contactpassword = [NSString stringWithUTF8String:(const char *)password];
            NSString *contactnumber = [NSString stringWithUTF8String:(const char *)number];
            
            ContactInfo *query = [[ContactInfo alloc] initWithUsername:contactName password:contactpassword contactNum:contactnumber];
            [contactlist addObject:query];
            [query release],query = nil;
        }
    }
    //释放statement占用资源
    sqlite3_finalize(statement);
    //关闭数据库
    [DataBase closeDataBase];
    
    return  contactlist;
}

/*
    if (sqlite3_exec(dataBase, "insert into ContactInfo values();", nil, nil, nil)== SQLITE_OK) {

        sqlite3_bind_text(statements, 1, [contactInfo.username UTF8String], -1, nil);
        sqlite3_bind_text(statements, 2, [contactInfo.password UTF8String], -1, nil);
        sqlite3_bind_text(statements, 3, [contactInfo.contactNum UTF8String], -1, nil);

    }
 */
+(BOOL)insertContactInfo:(ContactInfo *)contactInfo{

    //打开数据库
    sqlite3 *dataBase = [DataBase openDataBase];
    
    //实例化
    sqlite3_stmt *statements = nil;
    //执行SQL语句
    if (sqlite3_prepare_v2(dataBase, "insert into ContactInfo values(?,?,?)", -1, &statements, nil) == SQLITE_OK) {
        
        //绑定对应列数据的占位置的数据
        //方法中第二个参数，指的是在该参数在数据库中的计数单位以1开始，按顺序分别处理占位符的数据参数值的传递
        sqlite3_bind_text(statements, 1, [contactInfo.username UTF8String], -1, nil);
        sqlite3_bind_text(statements, 2, [contactInfo.password UTF8String], -1, nil);
        sqlite3_bind_text(statements, 3, [contactInfo.contactNum UTF8String], -1, nil);
        
        if (sqlite3_step(statements) == SQLITE_DONE) {
            sqlite3_finalize(statements);
            [DataBase closeDataBase];
            return YES;
        }
        
    }
    sqlite3_finalize(statements);
    [DataBase closeDataBase];
    return NO;

}
+(void)deleteContactInfo:(ContactInfo *)contactInfo{

    sqlite3 *dataBase = [DataBase openDataBase];
    
    sqlite3_stmt *statement = nil;
    if (sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@"delete from ContactInfo where contactNum='%@';",contactInfo.contactNum] UTF8String],-1, &statement, nil) == SQLITE_OK) {
        
        if(sqlite3_step(statement)==SQLITE_DONE){
            sqlite3_finalize(statement);
            [DataBase closeDataBase];
        }
        
    }
    
    sqlite3_finalize(statement);
    [DataBase closeDataBase];

    

}

+(void)updateContactInfo:(ContactInfo *)contactInfo{


    sqlite3 *dataBase = [DataBase openDataBase];
    
    sqlite3_stmt *statements = nil;
    if (sqlite3_prepare_v2(dataBase,[[NSString stringWithFormat:@"update set username=?,password=?,ContactNum=? from ContactInfo where contactNum=?"] UTF8String],-1, &statements, nil) == SQLITE_OK) {
        
        sqlite3_bind_text(statements, 1, [contactInfo.username UTF8String], -1, nil);
        sqlite3_bind_text(statements, 2, [contactInfo.password UTF8String], -1, nil);
        sqlite3_bind_text(statements, 3, [contactInfo.contactNum UTF8String], -1, nil);

        
            sqlite3_step(statements);
            sqlite3_finalize(statements);
            [DataBase closeDataBase];
        
    }
    
    sqlite3_finalize(statements);
    [DataBase closeDataBase];


}



@end
