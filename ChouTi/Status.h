//
//  Status.h
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Comment.h"

@class User;

typedef enum {
    Hot = 0,       //热榜
    News = 1,      //42区
    Scoff = 2,     //段子
    Rumour = 3,    //谣言
    Pic = 4,       //图片
    Tec = 100,     //挨踢1024
    Ask = 151      //你问我答
} SubjectType;

typedef enum {
    ActionOne = 0,     //无评论
    ActionTwo          //有评论
} ActionType;

typedef enum {
    OriginalWebPage = 0,     //信息的原始网页
    OwnPage,                 //自己整理的页面
    VideoPage,               //视频页面
    PicturePage              //图片页面
} FetchType;

typedef enum {
    PoolOne = 0,     //无评论
    PoolTwo          //有评论
} PoolType;

@interface Status : NSObject{
    ActionType actionType;          //有无评论
    SubjectType subjectType;        //所属标题类型
    FetchType fetchType;            //具体内容呈现方式
    NSNumber *statusId;             //信息ID
    NSNumber *createdTime;          //信息发布时间
    NSString *title;                //信息标题
    NSString *contentUrl;           //信息具体内容地址（包含查看原网页的链接）
    NSString *imageUrl;             //信息附带的图片
    NSString *originalUrl;          //信息来源网址
    NSString *originalImageUrl;     //信息附带的原图片
    User *summitedUser;             //信息的作者
    
    NSMutableArray *commentArr;     //信息的评论
    NSNumber *commentsCount;        //评论的数量
    NSNumber *upsCount;             //赞的数量
    BOOL isTop;                     //?????
    BOOL isHot;                     //是否进入热榜
    NSNumber *actionTime;              //进入热榜时间?????
    BOOL isBreak;                   //?????
    NSInteger hasSaved;                  //当前用户是否收藏
    NSInteger hasUped;                   //当前用户是否赞
    NSNumber *timeIntoPool;
}

@property (assign, nonatomic)ActionType actionType;
@property (assign, nonatomic)SubjectType subjectType;
@property (assign, nonatomic)FetchType fetchType;
@property (retain, nonatomic)NSNumber *statusId;
@property (retain, nonatomic)NSNumber *createdTime;
@property (retain, nonatomic)NSString *title;
@property (retain, nonatomic)NSString *contentUrl;
@property (retain, nonatomic)NSString *imageUrl;
@property (retain, nonatomic)NSString *originalUrl;
@property (retain, nonatomic)User *summitedUser;
@property (retain, nonatomic)NSMutableArray *commentArr;
@property (retain, nonatomic)NSNumber *commentsCount;
@property (retain, nonatomic)NSNumber *upsCount;
@property (assign, nonatomic)BOOL isTop;
@property (assign, nonatomic)BOOL isHot;
@property (retain, nonatomic)NSNumber *actionTime;
@property (assign, nonatomic)BOOL isBreak; 
@property (assign, nonatomic)NSInteger hasSaved;
@property (assign, nonatomic)NSInteger hasUped;
@property (retain, nonatomic)NSNumber *timeIntoPool;

- (NSString*)timestamp;
- (NSString*)hotTimeStamp;

+ (Status*)StatusWithJSONDictionary:(NSDictionary*)dic;
- (id)initWithJSONDictionary:(NSDictionary*)dic;

@end
