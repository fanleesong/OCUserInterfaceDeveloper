//
//  Comment.h
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Status.h"

@class User;
@class Status;

@interface Comment : NSObject {
    NSNumber *commentId;
    NSString *createdTime;
    NSString *content;
    NSNumber *depth;
    NSNumber *upsCount;
    NSNumber *downsCount;
    NSNumber *isVote;
    User *summitedUser;
}

@property (retain, nonatomic)NSNumber *commentId;
@property (retain, nonatomic)NSString *createdTime;
@property (retain, nonatomic)NSString *content;
@property (retain, nonatomic)NSNumber *depth;
@property (retain, nonatomic)NSNumber *upsCount;
@property (retain, nonatomic)NSNumber *downsCount;
@property (assign, nonatomic)NSNumber *isVote;
@property (retain, nonatomic)User *summitedUser;

- (NSString*)timestamp;

+ (Comment*)CommentWithJSONDictionary:(NSDictionary*)dic;
- (id)initWithJSONDictionary:(NSDictionary*)dic;

@end
