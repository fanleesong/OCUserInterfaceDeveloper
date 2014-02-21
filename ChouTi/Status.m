//
//  Status.m
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Status.h"

@implementation Status
@synthesize actionTime;
@synthesize subjectType;
@synthesize fetchType;
@synthesize statusId;
@synthesize createdTime;
@synthesize contentUrl;
@synthesize imageUrl;
@synthesize originalUrl;
@synthesize summitedUser;
@synthesize commentArr;
@synthesize commentsCount;
@synthesize upsCount;
@synthesize isTop;
@synthesize isHot;
@synthesize actionType;
@synthesize isBreak;
@synthesize hasSaved;
@synthesize hasUped;
@synthesize title;
@synthesize timeIntoPool;

+ (Status*)StatusWithJSONDictionary:(NSDictionary*)dic{
    return [[[Status alloc]initWithJSONDictionary:dic] autorelease];
}

- (id)initWithJSONDictionary:(NSDictionary*)dic{
    if(self = [super init]){
        self.actionType = [[dic objectForKey:@"action"] intValue];
        self.subjectType = [[dic objectForKey:@"subject_id"] intValue];
        self.fetchType = [[dic objectForKey:@"fetchType"] intValue];
        self.statusId = [dic objectForKey:@"id"];
        self.createdTime = [dic objectForKey:@"created_time"];
        self.title = [dic objectForKey:@"title"];
        self.imageUrl = [dic objectForKey:@"img_url"];
        self.contentUrl = [dic objectForKey:@"url"];
        self.commentsCount = [dic objectForKey:@"comments_count"];
        self.upsCount = [dic objectForKey:@"ups"];
        self.hasUped = [[dic objectForKey:@"has_uped"] intValue];
        self.hasSaved = [[dic objectForKey:@"has_saved"] intValue];
        self.actionTime = [dic objectForKey:@"action_time"];
        self.timeIntoPool = [dic objectForKey:@"time_into_pool"];
        
        self.summitedUser = [[User alloc] init];
        NSDictionary *mainDic = [dic objectForKey:@"submitted_user"];
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

- (NSString*)hotTimeStamp{
    NSString *timeStamp;
    
    time_t now;
    time(&now);
    time_t intoPoolAt = [timeIntoPool longLongValue]/1000000;
    
    int distance = (int)difftime(now, intoPoolAt);
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
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:intoPoolAt];        
        timeStamp = [dateFormatter stringFromDate:date];
    }
    return timeStamp;
}

- (NSString*)description{
    return [NSString stringWithFormat:@"title %@",title];
}

- (void)dealloc{
    [super dealloc];
    [statusId release];
    [title release];
    [imageUrl release];
    [contentUrl release];
    [summitedUser release];
}

@end
