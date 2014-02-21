//
//  MyComment.h
//  ChouTi
//
//  Created by administrator on 13-11-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Status.h"

@class User;
@class Status;

@interface MyComment : NSObject {
    NSString *content;
    NSNumber *createTime;
    NSNumber *downs;
    NSNumber *ups;
    NSNumber *commentId;
    NSNumber *isVote;
    NSNumber *linkId;
    NSString *linkTitle;
    User *user;
}

@property (retain, nonatomic)NSString *content;
@property (retain, nonatomic)NSNumber *downs;
@property (retain, nonatomic)NSNumber *ups;
@property (retain, nonatomic)NSNumber *commentId;
@property (retain, nonatomic)NSNumber *isVote;
@property (retain, nonatomic)NSNumber *linkId;
@property (retain, nonatomic)NSString *linkTitle;
@property (retain, nonatomic)NSNumber *createdTime;
@property (retain, nonatomic)User *user;

- (NSString*)timestamp;

+ (MyComment*)CommentWithJSONDictionary:(NSDictionary*)dic;
- (id)initWithJSONDictionary:(NSDictionary*)dic;

@end
