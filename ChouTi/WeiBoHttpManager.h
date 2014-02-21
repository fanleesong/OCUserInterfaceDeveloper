//
//  WeiBoHttpManager.h
//  test
//
//  Created by jianting zhu on 11-12-31.
//  Copyright (c) 2011年 Dunbar Science & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
//#import "StringUtil.h"
//#import "NSStringAdditions.h"

//************************************** Sinna **********************************************************

#define SINA_V2_DOMAIN            @"https://api.weibo.com/2" 

#define SINA_API_AUTHORIZE        @"https://api.weibo.com/oauth2/authorize"
#define SINA_API_ACCESS_TOKEN      @"https://api.weibo.com/oauth2/access_token"


#define SINA_APP_KEY              @"3601604349"
#define SINA_APP_SECRET           @"7894dfddefc2ce7cc6e9e9ca620082fb"
#define REDIRECT_URL               @"http://hi.baidu.com/jt_one"

#define USER_INFO_KEY_TYPE          @"requestType"

#define Sinna_USER_STORE_ACCESS_TOKEN     @"SinaAccessToken"
#define USER_STORE_EXPIRATION_DATE  @"SinaExpirationDate"
#define USER_STORE_USER_ID          @"SinaUserID"
#define USER_STORE_USER_NAME        @"SinaUserName"
#define USER_OBJECT                 @"USER_OBJECT"
#define NeedToReLogin               @"NeedToReLogin"

#define MMSinaRequestFailed         @"MMSinaRequestFailed"

typedef enum {
    SinnaGetOauthCode = 0,           //authorize_code
    SinnaGetOauthToken,              //access_token
    SinnaGetRefreshToken,            //refresh_token
    SinnaGetPublicTimeline,          //获取最新的公共微博
    SinnaGetUserID,                  //获取登陆用户的UID
    SinnaGetUserInfo,                //获取任意一个用户的信息
    SinnaPostText,                   //发布文字微博
   
    
}SinnaRequestType;

@class ASINetworkQueue;
@class SinaStatus;
@class SinaUser;


//Delegate
@protocol WeiBoHttpDelegate <NSObject>

@optional

//获取登陆用户的UID
-(void)didGetUserID:(NSString*)userID;

//获取任意一个用户的信息
-(void)didGetUserInfo:(SinaUser*)user;

//发布微博
-(void)didGetPostResult:(SinaStatus*)sts;


@end

@interface WeiBoHttpManager : NSObject
{
    ASINetworkQueue *requestQueue;
    id<WeiBoHttpDelegate> delegate;
    
    NSString *authCode;
    NSString *authToken;
    NSString *userId;
}

@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,assign) id<WeiBoHttpDelegate> delegate;
@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *authToken;
@property (nonatomic,copy) NSString *userId;

- (id)initWithDelegate:(id)theDelegate;

- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;

//留给webview用
-(NSURL*)getOauthCodeUrl;

//获取登陆用户的UID
-(void)getUserID;

//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid;

//发布文字微博
-(void)postWithText:(NSString*)text;

//获取当前登录用户及其所关注用户的最新微博
-(void)getHomeLine:(int64_t)sinceID maxID:(int64_t)maxID count:(int)count page:(int)page baseApp:(int)baseApp feature:(int)feature;

//获取某个用户最新发表的微博列表
-(void)getUserStatusUserID:(NSString *) uid sinceID:(int64_t)sinceID maxID:(int64_t)maxID count:(int)count page:(int)page baseApp:(int)baseApp feature:(int)feature;

//转发一条微博
//isComment(int):是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
-(void)repost:(NSString*)weiboID content:(NSString*)content withComment:(int)isComment;



@end
