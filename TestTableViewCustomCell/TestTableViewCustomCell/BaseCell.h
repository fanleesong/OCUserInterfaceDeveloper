//
//  BaseCell.h
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  BaseModel;

@interface BaseCell : UITableViewCell

@property (nonatomic, retain) BaseModel *dataForCell;
+ (CGFloat)cellHeightForModel:(BaseModel *)dataForCell;

@end
