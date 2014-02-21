//
//  ContactInfo.m
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-21.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "ContactInfo.h"

@implementation ContactInfo

-(void)dealloc{
    [_contactNum release];
    [_username release];
    [_password release];
    [super dealloc];
}

-(id)initWithUsername:(NSString *)username
             password:(NSString *)password
           contactNum:(NSString *)contactNum{
    
    if (self=[super init]) {
        self.contactNum = contactNum;
        self.username = username;
        self.password = password;
    }
    
    
    return self;
}

@end
