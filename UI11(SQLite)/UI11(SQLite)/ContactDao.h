//
//  ContactDao.h
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactInfo;

@interface ContactDao : NSObject

//查询所有
+(NSMutableArray *)selAllContactInfo;
//添加数据
+(BOOL)insertContactInfo:(ContactInfo *)contactInfo;
//删除
+(void)deleteContactInfo:(ContactInfo *)contactInfo;
//更新
+(void)updateContactInfo:(ContactInfo *)contactInfo;


@end
