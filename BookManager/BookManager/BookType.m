//
//  BookType.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookType.h"

@implementation BookType

-(void)dealloc{
    
    [_remark release],_remark = nil;
    [_typeName release],_typeName = nil;
    [super dealloc];
    
}


@end
