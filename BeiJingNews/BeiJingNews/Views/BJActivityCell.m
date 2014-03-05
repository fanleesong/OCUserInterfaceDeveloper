//
//  BJActivityCell.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-5.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJActivityCell.h"

@implementation BJActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //初始化激活标示
        self.activityIndicatorView = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100,8,30,30)] autorelease];
        //设置活动指示标的样式
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        [self.activityIndicatorView startAnimating];//发送开始动画
        [self addSubview:self.activityIndicatorView];
        
        self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 7,200 ,30 )];
        self.loadingLabel.text = @"正在加载中...";
        self.loadingLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.loadingLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{

    [_activityIndicatorView release];
    [_loadingLabel release];
    [super dealloc];
}

@end
