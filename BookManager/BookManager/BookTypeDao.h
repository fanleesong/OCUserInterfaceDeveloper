//
//  BookTypeDao.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookType;

@interface BookTypeDao : NSObject


+(NSMutableArray *)findAllBooksTypeInfo;//查询所有
+(BookType *)findBookTypeById:(int)bookTypeid;//根据id查询图书类型

@end
