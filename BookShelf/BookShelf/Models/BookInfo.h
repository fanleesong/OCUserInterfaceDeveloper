//
//  BookInfo.h
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookInfo : NSObject

@property (nonatomic,assign) NSInteger bookID;//图书编号
@property (nonatomic,retain) NSString *bookName;//图书名称
@property (nonatomic,retain) NSString *bookPrice;//图书价格
@property (nonatomic,retain) NSString *bookCategory;//图书类别
@property (nonatomic,retain) UIImage *bookAvatar;//图书封面
@property (nonatomic,assign) BOOL isStatus;

-(id)initWithBookID:(NSInteger)bookID
             bookName:(NSString *)bookName
            bookPrice:(NSString *)bookPrice
         bookCategory:(NSString *)bookCategory
           bookAvatar:(UIImage *)bookAvatar;


@end
