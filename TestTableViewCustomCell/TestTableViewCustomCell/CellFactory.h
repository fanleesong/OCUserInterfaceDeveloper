//
//  CellFactory.h
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseModel;
@class BaseCell;

@interface CellFactory : NSObject

+ (BaseCell *)cellForModel:(BaseModel *)dataModel reuseIdentifier:(NSString *)cellIdentifier;
+ (Class)cellClassForModel:(BaseModel *)dataModel;

@end

BaseCell *cellForModel(BaseModel *dataModel,NSString *cellIdentifier);
Class cellClassForModel(BaseModel *dataModel);
