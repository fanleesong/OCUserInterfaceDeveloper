//
//  RenrenHttpManger.h
//  ChouTi
//
//  Created by user on 13-11-9.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "SinaStatus.h"

#define RENREN_API_AUTHRIZE    @"http://graph.renren.com/oauth/authorize"
#define RENREN_API_ACESS_TOKEN @"https://graph.renren.com/oauth/token"
#define RENREN_APP_KEY         @"YOUR API KEY"
#define RENREN_APP_SECRECT     @"YOUR APP ID"
#define RENREN_REDIRECTURL            @"http://widget.renren.com/callback.html"
#define RENREN_INFO_KEY_TYPE          @"requestType"

#define RENREN_STORE_ACCESS_TOKEN     @"AccessToken"
#define RENREN_STORE_USER_ID          @"UserID"

#define NeedToReLogin               @"NeedToReLogin"
#define RequestFailed         @"RequestFailed"
#define RENREN_STORE_EXPIRATION_DATE  @"ExpirationDate"

typedef enum {
    RenrenGetOauthCode = 0,           //authorize_code
    RenrenGetOauthToken,              //access_token
    RenrenGetRefreshToken,            //refresh_token
    RenrenGetPublicTimeline,          //获取最新的公共微博
    RenrenGetUserID,                  //获取登陆用户的UID
    RenrenGetUserInfo,                //获取任意一个用户的信息
    RenrenPostText,                   //发布文字微博


}RenrenRequestType;

@class ASINetworkQueue;
@class SinaStatus;
@class SinaUser;

@protocol RenrenHttpDelegate <NSObject>

@optional

//获取登陆用户的UID
-(void)didGetOpenID:(NSString*)userID;

//获取任意一个用户的信息
-(void)didGetTencentUserInfo:(SinaUser*)user;

//发布微博
-(void)didGetPostResult:(SinaStatus*)sts;

@end

@interface RenrenHttpManger : NSObject{
    ASINetworkQueue *requestQueue;
    id<RenrenHttpDelegate> delegate;

    NSString *authCode;
    NSString *authToken;
    NSString *userId;
}

@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,assign) id<RenrenHttpDelegate> delegate;
@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *authToken;


- (id)initWithDelegate:(id)theDelegate;

- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;

//留给webview用
-(NSURL*)getOauthCodeUrl;

//获取登陆用户的UID
//-(void)getOpenID;

//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid;

//发布文字微博
-(void)postWithText:(NSString*)text;


@end 
