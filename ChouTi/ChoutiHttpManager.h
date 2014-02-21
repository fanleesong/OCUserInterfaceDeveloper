//
//  ChoutiHttpManager.h
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

#define USER_STORE_USER_ID          @"SinaUserID"
#define CHOUTI_STORE_USER_NAME        @"SinaUserName"
#define CHOUTI_V2_DOMAIN              @"https://api.weibo.com/2"
#define USER_INFO_KEY_TYPE          @"requestType"

typedef enum {
    ChoutiGetOauthCode = 0,           //authorize_code
    ChoutiGetOauthToken,              //access_token
    ChoutiGetRefreshToken,            //refresh_token
    ChoutiGetPublicTimeline,          //获取最新的公共微博
    ChoutiGetUserID,                  //获取登陆用户的UID
    ChoutiGetUserInfo,                //获取任意一个用户的信息
    ChoutiPostText,                   //发布文字微博
    
    
}ChoutiRequestType;

@class ASINetworkQueue;
@class Status;
@class User;

@protocol ChoutiHttpDelegate <NSObject>

@optional

//获取登陆用户的UID
-(void)didGetUserID:(NSString*)userID;

//获取任意一个用户的信息
-(void)didGetUserInfo:(User*)user;

//发布微博
-(void)didGetPostResult:(Status*)sts;


@end



@interface ChoutiHttpManager : NSObject{
    ASINetworkQueue *requestQueue;
    id<ChoutiHttpDelegate> delegate;
    
   
    NSString *userId;
}

@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,assign) id<ChoutiHttpDelegate> delegate;

@property (nonatomic,copy) NSString *userId;
- (id)initWithDelegate:(id)theDelegate;

- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;




//获取任意一个用户的信息
-(void)login;

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
