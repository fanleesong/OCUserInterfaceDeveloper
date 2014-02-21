//
//  TencentHttpManger.h
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"
#import "SinaStatus.h"
//#import "StringUtil.h"
//#import "NSStringAdditions.h"
//************************************* Tencent *********************************************************
/*
#define WiressSDKDemoAppKey     @"801213517"
#define WiressSDKDemoAppSecret  @"9819935c0ad171df934d0ffb340a3c2d"
#define REDIRECTURI             @"http://www.ying7wang7.com"

#define TCWBSDKAPIDomain        @"https://open.t.qq.com/api/"
#define kWBAuthorizeURL         @"https://open.t.qq.com/cgi-bin/oauth2/authorize/ios"
#define kWBAccessTokenURL       @"https://open.t.qq.com/cgi-bin/oauth2/access_token"
#define kWBLonAndLatURL         @"http://ugc.map.soso.com/rgeoc/"

#define OAUTH_CONSUMER_KEY      @"oauth_consumer_key"
#define TOKEN                   @"token"
#define ACCESS_TOKEN            @"access_token"
#define REFRESH_TOKEN           @"refresh_token"
#define EXPIRES_IN              @"expires_in"
#define OPENID                  @"openid"
#define CLIENTIP                @"clientip"
#define OAUTH_VERSION           @"oauth_version"
#define SCOPE                   @"scope"

#define CLIENT_ID               @"client_id"
#define GRANT_TYPE              @"grant_type"
#define RESPONSE_TYPE           @"response_type"
//#define REDIRECT_URI            @"redirect_uri"

#define TCWBSDKErrorDomain       @"TCSDKErrorDomain"  //生成error对象时的自定义domain
#define TCWBSDKErrorCodeKey      @"TCSDKErrorCodeKey" //error对应的键值

//https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=APP_KEY&response_type=code&redirect_uri=http://www.myurl.com/example
*/
//************************************** Sinna **********************************************************

#define TENCENT_V2_DOMAIN              @"https://open.t.qq.com/api/"
#define Format                         @"json"
#define SCOPE                          @"all"
#define CLIENTIP                       @"162.105.65.37"
#define TENCENT_API_AUTHORIZE         @"https://open.t.qq.com/cgi-bin/oauth2/authorize"

#define TENCENT_API_ACCESS_TOKEN      @"https://open.t.qq.com/cgi-bin/oauth2/access_token"


#define TENCENT_APP_KEY     @"801213517"           

#define TENCENT_APP_SECRET    @"9819935c0ad171df934d0ffb340a3c2d"        

#define REDIRECTURL             @"http://www.ying7wang7.com"


#define Tencen_INFO_KEY_TYPE          @"requestType"

#define Tencen_STORE_ACCESS_TOKEN     @"TencenAccessToken"
#define Tencen_STORE_EXPIRATION_DATE  @"TencenExpirationDate"
//#define Tencen_STORE_USER_ID          @"TencenUserID"
#define Tencen_STORE_USER_NAME        @"TencenUserName"
#define Tencen_STORE_OPEN_ID          @"openid"
#define Tencen_STORE_OPEN_KEY         @"openkey"

#define Tencen_OBJECT                 @"USER_OBJECT"
#define Tencen_NeedToReLogin          @"NeedToReLogin"

#define MMSinaRequestFailed         @"MMSinaRequestFailed"

typedef enum {
    GetOauthCode = 0,           //authorize_code
    GetOauthToken,              //access_token
    GetRefreshToken,            //refresh_token
    GetPublicTimeline,          //获取最新的公共微博
    GetOpenID,                  //获取登陆用户的UID
    GetOpenKEY,
    GetUserInfo,                //获取任意一个用户的信息
    PostTxt,                   //发布文字微博
    
    
}RequestTypee;

@class ASINetworkQueue;
@class SinaStatus;
@class SinaUser;

@protocol TencentHttpDelegate <NSObject>

@optional

//获取登陆用户的UID
-(void)didGetOpenID:(NSString*)userID;

//获取任意一个用户的信息
-(void)didGetTencentUserInfo:(SinaUser*)user;

//发布微博
-(void)didGetPostResult:(SinaStatus*)sts;


@end


@interface TencentHttpManger : NSObject {
ASINetworkQueue *requestQueue;
id<TencentHttpDelegate> delegate;

NSString *authCode;
NSString *authToken;
NSString *userId;
}

@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,assign) id<TencentHttpDelegate> delegate;
@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *authToken;
@property (nonatomic,copy) NSString *openId;
@property (nonatomic,copy) NSString *openKey;

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
