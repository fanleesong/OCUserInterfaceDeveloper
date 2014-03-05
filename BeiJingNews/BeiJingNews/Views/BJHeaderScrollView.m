//
//  BJHeaderScrollView.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJHeaderScrollView.h"
#import "BJNewsItem.h"
#import "UIImageView+WebCache.h"

@implementation BJHeaderScrollView

- (id)initWithFrame:(CGRect)frame managerObjectsArray:(NSArray *)objectsArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentSize = CGSizeMake(320 * objectsArray.count, frame.size.height);
        self.pagingEnabled = YES;//整屏滑动
        //不显示横和竖滑动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
        for (int i = 0; i<objectsArray.count; i++) {
            
            UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i,0, frame.size.width, frame.size.height)];
            
#warning 此处需网路请求数据，下载图片，待完善
            BJNewsItem *item = [objectsArray objectAtIndex:i];
            [headerImageView setImageWithURL:[NSURL URLWithString:item.newsPicURL]];
            
            
            [self addSubview:headerImageView];
            [headerImageView release],headerImageView = nil;
            
        }
        self.newsObjectsArray = objectsArray;
        self.newsTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-25, 320, 25)] autorelease];
        self.newsTitleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.85];
        self.newsTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        self.newsTitleLabel.backgroundColor = [UIColor lightGrayColor];
    
        
        BJNewsItem *firstItem = [objectsArray firstObject];
        self.newsTitleLabel.text = firstItem.newsTitle;
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)dealloc{
    [_newsObjectsArray release];
    [_newsTitleLabel release];
    [super dealloc];

}

@end
