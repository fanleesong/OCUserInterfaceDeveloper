//
//  BJActivityCell.h
//  BeiJingNews
//
//  Created by 范林松 on 14-3-5.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJActivityCell : UITableViewCell

@property(nonatomic,retain)UIActivityIndicatorView *activityIndicatorView;//上拉加载的视图
@property(nonatomic,retain)UILabel *loadingLabel;

@end
