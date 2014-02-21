//
//  MyComment.m
//  ChouTi
//
//  Created by administrator on 13-11-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MyComment.h"

@implementation MyComment
@synthesize content;
@synthesize downs;
@synthesize ups;
@synthesize commentId;
@synthesize isVote;
@synthesize linkId;
@synthesize linkTitle;
@synthesize createdTime;
@synthesize user;

+ (MyComment*)CommentWithJSONDictionary:(NSDictionary*)dic{
    return [[[MyComment alloc]initWithJSONDictionary:dic] autorelease];
}

- (id)initWithJSONDictionary:(NSDictionary*)dic{
    if(self = [super init]){
        self.content = [dic objectForKey:@"content"];
        self.downs = [dic objectForKey:@"downs"];
        self.ups = [dic objectForKey:@"ups"];
        self.commentId = [dic objectForKey:@"id"];
        self.isVote = [dic objectForKey:@"is_vote"];
        self.linkId = [dic objectForKey:@"link_id"];
        self.linkTitle = [dic objectForKey:@"link_title"];
        self.createdTime = [dic objectForKey:@"created_time"];
        user = [[User alloc]init];
        NSDictionary *userDic = [dic objectForKey:@"user"];
        user.userID = [userDic objectForKey:@"jid"];
        user.nickName = [userDic objectForKey:@"nick"];
        user.isBindPhone = [[userDic objectForKey:@"isBindPhone"] intValue];
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

@end
