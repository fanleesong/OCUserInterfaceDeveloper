//
//  UserInfo.h
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserInfo : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *imagePath;

- (instancetype)initWithName:(NSString *)name
                 phoneNumber:(NSString *)phoneNumber
                   imagePath:(NSString *)imagePath;
+ (instancetype)userInfoWithName:(NSString *)name
                     phoneNumber:(NSString *)phoneNumber
                       imagePath:(NSString *)imagePath;

- (UIImage *)userImage;

@end
