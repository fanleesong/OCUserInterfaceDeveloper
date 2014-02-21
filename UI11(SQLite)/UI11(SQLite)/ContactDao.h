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
////增加数据
//+(void)saveContactInfo:(ContactInfo *)contactInfo;
////删除联系人
//+(void)delContactInfo:(ContactInfo *)contactInfo;
////修改
//+(void)editContactInfo:(ContactInfo *)contactInfo;

@end
