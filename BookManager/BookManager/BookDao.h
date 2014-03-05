//
//  BookDao.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookType.h"
@class Books;


@interface BookDao : NSObject

+(NSMutableArray *)findAllBooksInfo;//查询所有
+(NSMutableArray *)findBookByStatus:(int)isDelete;//根据状态查询
+(BOOL)saveBookInfo:(Books *)bookInfo;//插入数据
+(BOOL)deleteAllBookByIds:(NSMutableArray *)IdsArray;//删除所有书籍
+(BOOL)deleteBookById:(Books *)bookInfo;//删除数据
+(BOOL)updateBookById:(Books *)bookInfo;//更新数据


@end
