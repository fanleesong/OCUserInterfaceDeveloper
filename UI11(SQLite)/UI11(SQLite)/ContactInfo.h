//
//  ContactInfo.h
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *contactNum;

-(id)initWithUsername:(NSString *)username
             password:(NSString *)password
           contactNum:(NSString *)contactNum;


@end
