//
//  MyCell.h
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"


@class UserInfo;

@interface MyCell : BaseCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *phoneLabel;
@property (nonatomic, retain) UIImageView *userImageView;

@end
