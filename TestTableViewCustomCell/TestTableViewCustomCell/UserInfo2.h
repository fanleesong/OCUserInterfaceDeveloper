//
//  UserInfo2.h
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo2 : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *imagePath;

- (instancetype)initWithName:(NSString *)name
                       email:(NSString *)email
                   imagePath:(NSString *)imagePath;
+ (instancetype)userInfo2WithName:(NSString *)name
                            email:(NSString *)email
                        imagePath:(NSString *)imagePath;
- (UIImage *)userImage;

@end
