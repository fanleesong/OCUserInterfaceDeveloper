//
//  DataBaseManager.h
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BookInfo.h"

@interface DataBaseManager : NSObject

+(FMDatabase *)openDataBase;
+(void)closeDataBase;

+(NSMutableArray *)findAllBookItemInfo:(BOOL)isShow;
+(NSMutableArray *)findAllBookItemInfo:(NSString *)category isShow:(BOOL)isShow;
+(BOOL)insertOneBookItemWithBooKInfo:(BookInfo *)bookItemInfo;
+(BOOL)deleteOneBookItemWithBookInfo:(BookInfo *)bookItemInfo;
+(BOOL)updateOneBookItemWithBookInfo:(BookInfo *)bookItemInfo;



@end
