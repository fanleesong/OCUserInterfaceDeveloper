//
//  BookInfo.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookInfo.h"

@implementation BookInfo

-(void)dealloc{
    
    [_bookAvatar release];
    [_bookName release];
    [_bookPrice release];
    [_bookCategory release];
    [super dealloc];

}


-(id)initWithBookID:(NSInteger)bookID bookName:(NSString *)bookName bookPrice:(NSString *)bookPrice bookCategory:(NSString *)bookCategory bookAvatar:(UIImage *)bookAvatar{

    if (self = [super init]) {
        self.bookCategory = bookCategory;
        self.bookID = bookID;
        self.bookName = bookName;
        self.bookPrice = bookPrice;
        self.bookAvatar = bookAvatar;
        self.isStatus = YES;
    }

    return self;
}

@end
