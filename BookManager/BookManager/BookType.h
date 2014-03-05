//
//  BookType.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookType : NSObject

@property(nonatomic,assign) int typeId;//分类id
@property(nonatomic,retain) NSString *typeName;//分类名
@property(nonatomic,retain) NSString *remark;//备注

@end
