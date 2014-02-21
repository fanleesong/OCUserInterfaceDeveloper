//
//  Comment.m
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize commentId;
@synthesize createdTime;
@synthesize content;
@synthesize depth;
@synthesize upsCount;
@synthesize downsCount;
@synthesize isVote;
@synthesize summitedUser;

+ (Comment*)CommentWithJSONDictionary:(NSDictionary*)dic{
    return [[Comment alloc]initWithJSONDictionary:dic];
}

- (id)initWithJSONDictionary:(NSDictionary*)dic{
    if(self = [super init]){
        self.commentId = [dic objectForKey:@"id"];
//        self.createdTime
        self.createdTime = [dic objectForKey:@"created_time"];
        self.content = [dic objectForKey:@"content"];
        self.depth = [dic objectForKey:@"depth"];
        self.upsCount = [dic objectForKey:@"ups"];
        self.downsCount = [dic objectForKey:@"downs"];
        self.isVote = [dic objectForKey:@"is_vote"];
        summitedUser = [[User alloc] init];
        NSDictionary *mainDic  = [dic objectForKey:@"user"];
        summitedUser.userID = [mainDic objectForKey:@"jid"];
        summitedUser.nickName = [mainDic objectForKey:@"nick"];
        summitedUser.imageURL = [mainDic objectForKey:@"img_url"];
    }
    return self;
}

- (NSString*)timestamp{
    NSString *timeStamp;
    
    time_t now;
    time(&now);
    time_t createdAt = [createdTime longLongValue]/1000000;
    
    int distance = (int)difftime(now, createdAt);
    if(distance < 0) distance = 0;
    if(distance < 60) {
        timeStamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }else if(distance < 60 * 60) {  
        distance = distance / 60;
        timeStamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }else if(distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timeStamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }else if(distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timeStamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }else if(distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timeStamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }else{
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];        
        timeStamp = [dateFormatter stringFromDate:date];
    }
    return timeStamp;
}

- (void)dealloc{
    [commentId release];
    [content release];
    [upsCount release];
    [downsCount release];
    [summitedUser release];
    [super dealloc];
}

@end
