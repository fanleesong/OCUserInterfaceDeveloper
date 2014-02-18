//
//  ContactItem.m
//  contantDemo
//
//  Created by 范林松 on 14-2-17.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "ContactItem.h"

@implementation ContactItem


-(void)dealloc{
    [_contactAvatarImage release];
    [_contactName release];
    [_contactAvatarImage release];
    [super dealloc];
}

@end
