//
//  BJNewsItem.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJNewsItem.h"

@implementation BJNewsItem

-(id)initWithDictionatry:(NSDictionary *)dictionary{

    if (self = [super init]) {
        
        self.newsTitle = [dictionary objectForKey:@"title"];
        self.newsSummary = [dictionary objectForKey:@"summary"];
        self.newsPublishDate = [dictionary objectForKey:@"PUBLISHDATE"];
        self.newsPicURL = [dictionary objectForKey:@"picUrl"];
        self.newsURL = [dictionary objectForKey: @"newsUrl"];
        
    }
    return self;
}


-(void)dealloc{

    [_newsSummary release];
    [_newsPublishDate release];
    [_newsTitle release];
    [_newsURL release];
    [_newsPicURL release];
    [super dealloc];

}
@end
