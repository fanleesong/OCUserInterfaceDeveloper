//
//  CellFactory.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "CellFactory.h"
#import "BaseModel.h"
#import "BaseCell.h"
#import "MyCell.h"
#import "UserInfo.h"
#import "UserInfo2.h"
#import "MyCell2.h"

@implementation CellFactory

+ (BaseCell *)cellForModel:(BaseModel *)dataModel reuseIdentifier:(NSString *)cellIdentifier{
    //获取model对应的cell子类
    Class cellClass = [CellFactory cellClassForModel:dataModel];
    //用cell子类初始化对象
    BaseCell *cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    return [cell autorelease];
}

+ (Class)cellClassForModel:(BaseModel *)dataModel{
    Class cellClass = Nil;
    if ([dataModel isKindOfClass:[UserInfo class]]) {
        cellClass = [MyCell class];
    }
    
    if ([dataModel isKindOfClass:[UserInfo2 class]]) {
        cellClass = [MyCell2 class];
    }
    return cellClass;
}



@end

BaseCell *cellForModel(BaseModel *dataModel,NSString *cellIdentifier){
    //获取model对应的cell子类
    Class cellClass = cellClassForModel(dataModel);
    //用cell子类初始化对象
    BaseCell *cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    return [cell autorelease];
}
Class cellClassForModel(BaseModel *dataModel){
    Class cellClass = Nil;
    if ([dataModel isKindOfClass:[UserInfo class]]) {
        cellClass = [MyCell class];
    }
    
    if ([dataModel isKindOfClass:[UserInfo2 class]]) {
        cellClass = [MyCell2 class];
    }
    return cellClass;
}

