//
//  Books.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Books : NSObject

@property(nonatomic,assign) int bookId;//图书id
@property(nonatomic,retain) NSString *bookName;//书名
@property(nonatomic,retain) NSString *bookPage;//封面路径
@property(nonatomic,assign) float bookPrice;//单价
@property(nonatomic,assign) int typeId;//图书类型<外键>
@property(nonatomic,retain) NSString *typeName;//类别名<用于显示类别>
@property(nonatomic,assign) int isDelete;//状态

//create table bookInfo (bookid int primary key not NULL,bookName varchar(50),bookPage varchar(200),bookprice double,typeId int ,typeName varchar(50),isDelete int);

@end
