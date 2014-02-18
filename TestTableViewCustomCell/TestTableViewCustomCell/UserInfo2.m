//
//  UserInfo2.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "UserInfo2.h"

@implementation UserInfo2

- (instancetype)initWithName:(NSString *)name
                       email:(NSString *)email
                   imagePath:(NSString *)imagePath{
    self = [super init];
    if (self) {
        [self setName:name];
        [self setEmail:email];
        [self setImagePath: imagePath];
    }
    return self;
}
+ (instancetype)userInfo2WithName:(NSString *)name
                            email:(NSString *)email
                        imagePath:(NSString *)imagePath{
    UserInfo2 *userInfo = [[UserInfo2 alloc] initWithName:name email:email imagePath:imagePath];
    return [userInfo autorelease];
}
- (UIImage *)userImage{
    UIImage *userImage = [[UIImage alloc] initWithContentsOfFile:_imagePath];
    return [userImage autorelease];
}


@end
