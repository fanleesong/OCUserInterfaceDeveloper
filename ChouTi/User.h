//
//  User.h
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
#import "Comment.h"

@class Status;

@interface User : NSObject{
    NSString *userID;
    NSString *nickName;
    NSString *imageURL;
    NSMutableArray *commentArr;
    NSMutableArray *likedArr;
    NSMutableArray *saveArr;
    NSMutableArray *submittedArr;
    BOOL isBindPhone;
    BOOL sex;   //?????
}

@property (retain, nonatomic)NSString *userID;
@property (retain, nonatomic)NSString *nickName;
@property (retain, nonatomic)NSString *imageURL;
@property (retain, nonatomic)NSMutableArray *commentArr;
@property (retain, nonatomic)NSMutableArray *likedArr;
@property (retain, nonatomic)NSMutableArray *saveArr;
@property (retain, nonatomic)NSMutableArray *submittedArr;
@property (assign, nonatomic)BOOL isBindPhone;
@property (assign, nonatomic)BOOL sex;

@end
