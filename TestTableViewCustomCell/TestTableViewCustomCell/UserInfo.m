//
//  UserInfo.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithName:(NSString *)name
                 phoneNumber:(NSString *)phoneNumber
                   imagePath:(NSString *)imagePath{
    self = [super init];
    if (self) {
        [self setName:name];
        [self setPhoneNumber:phoneNumber];
        [self setImagePath:imagePath];
    }
    
    return self;
}
+ (instancetype)userInfoWithName:(NSString *)name
                     phoneNumber:(NSString *)phoneNumber
                       imagePath:(NSString *)imagePath{
    UserInfo *userInfo = [[UserInfo alloc] initWithName:name phoneNumber:phoneNumber imagePath:imagePath];
    return [userInfo autorelease];
}

- (UIImage *)userImage{
    UIImage *image = [UIImage imageWithContentsOfFile:_imagePath];
    return [[image retain] autorelease];
}


@end
