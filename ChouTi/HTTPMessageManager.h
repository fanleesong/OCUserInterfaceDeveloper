//
//  HTTPMessageManager.h
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASINetworkQueue.h"
#import "Status.h"

#define URL_DOMAIN @"http://api.chouti.com"
#define UNLOGIN_SOURCE @"c40fe2f61bcfd611177be71ec305196b"
#define API_AUTHORIZE @""
#define API_ACCESS_TOKEN @""
#define USER_STORE_ACCESS_TOKEN @"c40fe2f61bcfd611177be71ec305196bFD4A7FDA4A0C7221ED9199EF80E92931"
#define REQUEST_TYPE @"requestType"
#define USER_STORE_COMMENTS_COUNT @"userCommentsCount"
#define USER_STORE_LIKED_COUNT @"userLikedCount"
#define USER_STORE_SAVE_COUNT @"userSaveCount"
#define USER_STORE_SUBMITTED_COUNT @"userSubmittedCount"


#define GotUserInfo @"gotUserInfo"
#define GotHotHomePageInfo @"gotHotHomePageInfo"
#define GotNewsHomePageInfo @"gotNewsHomePageInfo"
#define GotScoffHomePageInfo @"gotScoffHomePageInfo"
#define GotPicHomePageInfo @"gotPicHomePageInfo"
#define GotTecHomePageInfo @"gotTecHomePageInfo"
#define GotAskHomePageInfo @"gotAskHomePageInfo"
#define GotCommentlistIds @"gotCommentlistIds"
#define GotCommentList @"gotCommentList"
#define GotMyPublishList @"gotMyPublishList"
#define GotMyCommentsList @"gotMyCommentsList"
#define GotMySaveList @"gotMySaveList"
#define GotMyRecommentList @"gotMyRecommentList"
#define PostUpMessage @"postUpMessage"
#define PostCancelUpMessage @"postCancelUpMessage"
#define PostSaveMessage @"postSaveMessage"
#define PostCancelSaveMessage @"postCancelSaveMessage"
#define PostUpOrDownComment @"postUpOrDownComment"
#define PostResponseToMessage @"postResponseToMessage"
#define PostTextMessage @"postTextMessage"
#define PostPicMessage @"postPicMessage"
#define PostLinkMessage @"postLinkMessage"

typedef enum {
    GetAccessToken = 0, 
    GetHotHomePageInfo,        //获取最新的热榜信息
    GetNewsHomePageInfo,       //获取最新的42区信息
    GetScoffHomePageInfo,      //获取最新的段子信息
    GetPicHomePageInfo,        //获取最新的图片信息
    GetTecHomePageInfo,        //获取最新的挨踢1024信息
    GetAskHomePageInfo,        //获取最新的你问我答信息
    GetUserProfileInfo,        //获取当前用户个人信息
    GetUnreadCount,            //获取当前用户消息未读数
    GetCommentsListIds,        //获取某条信息评论者的id
    GetCommentsList,           //获取某条信息的具体评论
    GetMyPublishList,          //获取登陆用户发布过的内容
    GetMyCommentsList,         //获取登录用户发表过的评论
    GetMySaveList,             //获取登录用户私藏的内容
    GetMyRecommentList,        //获取登陆用户推荐过的内容
    UpTrend,                   //赞某条信息
    CancelUpTrend,             //取消赞
    SaveTrend,                 //私藏某条信息
    CancelSaveTrend,           //取消私藏
    UpOrDownComment,           //顶或踩某条评论
    ResponseComment,           //评论某条信息或回复某条评论
    PostText,                  //发送文字信息
    PostImage,                 //发送图片信息
    PostUrl                    //发送链接
} RequestType;

@interface HTTPMessageManager : NSObject {
    NSString *accessToken;
    ASINetworkQueue *requestQueue;
}

@property (retain, nonatomic)NSString *accessToken;

+ (HTTPMessageManager*)getInstance;

- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;

- (NSURL*)getOauthCodeUrl;
- (void)getUserInfo;
- (void)didGetUserInfo:(NSDictionary*)infoDic;
- (void)getHotHomePageInfo;
- (void)didGetHotHomePageInfo:(NSArray*)statusArray;
- (void)getNewsHomePageInfo;
- (void)didGetNewsHomePageInfo:(NSArray*)statusArray;
- (void)getScoffHomePageInfo;
- (void)didGetScoffHomePageInfo:(NSArray*)statusArray;
- (void)getPicHomePageInfo;
- (void)didGetPicHomePageInfo:(NSArray*)statusArray;
- (void)getTecHomePageInfo;
- (void)didGetTecHomePageInfo:(NSArray*)statusArray;
- (void)getAskHomePageInfo;
- (void)didGetAskHomePageInfo:(NSArray*)statusArray;
- (void)getCommentList:(NSNumber*)linkId;
- (void)didGetCommentList:(NSArray*)commentsIdsArr;
- (void)getRealComments:(NSArray*)ids;
- (void)didGetRealComments:(NSArray*)commentsArr;
- (void)getMyPublishList;
- (void)didGetMyPublishList:(NSArray*)publishList;
- (void)getMyCommentsList;
- (void)didGetMyCommentsList:(NSArray*)commentsList;
- (void)getMySavedList;
- (void)didGetMySaveList:(NSArray*)savedList;
- (void)getMyRecommendList;
- (void)didGetMyRecommendList:(NSArray*)recommendList;
- (void)postUpMessage:(NSNumber*)linkId;
- (void)didPostUpMessage:(NSNumber*)upsCount;
- (void)postCancelUpMessage:(NSNumber*)linkId;
- (void)didPostCancelUpMessage:(NSNumber*)upsCount;
- (void)postSaveMessage:(NSNumber*)linkId;
- (void)didPostSaveMessage:(NSNumber*)ids;
- (void)postCancelSaveMessage:(NSNumber*)linkId;
- (void)didPostCancelSaveMessage:(NSNumber*)ids;
- (void)postUpOrDownComment:(NSNumber*)commentId andVote:(NSNumber*)vote;
- (void)didPostUpOrDownComment:(NSDictionary*)responseDic;
- (void)postResponseToMessage:(NSNumber*)messageId andParentId:(NSNumber*)parentId andContent:(NSString*)content;
- (void)didPostResponseToMessage:(NSDictionary*)commentDic;
- (void)postTextMessage:(NSString*)title;
- (void)didPostTextMessage:(NSDictionary*)responseDic;
- (void)postPicMessage:(NSData*)data andText:(NSString*)text;
- (void)didPostPicMessage:(NSDictionary*)responseDic;

@end
