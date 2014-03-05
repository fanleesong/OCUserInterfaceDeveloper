//
//  Books.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "Books.h"

@implementation Books
-(void)dealloc{
    
    [_bookName release];
    [_bookPage release];
    [_typeName release];
    [super dealloc];

}
@end
