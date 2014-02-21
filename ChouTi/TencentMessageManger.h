//
//  TencentMessageManger.h
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentHttpManger.h"

//获取登陆用户的UID
//返回userID(NSString)
#define TencentGotOpenID @"MMSinaGotUserID"
#define TencentGotOpenKey @"MMSinaGotOpenKey"

//获取任意一个用户的信息
//返回一个User对象
#define TencentGotUserInfo @"MMSinaGotUserInfo"

//发布微博
//返回一个Status对象
#define TencentGotPostResult @"MMSinaGotPostResult"

//转发一条微博
//返回一个Status对象
#define TencentGotRepost @"MMSinaGotRepost"






@interface TencentMessageManger : NSObject<TencentHttpDelegate>{
    TencentHttpManger *httpManager;
}

@property (nonatomic,retain)TencentHttpManger *httpManager;

+(TencentMessageManger *)getInstance;

//查看Token是否过期
- (BOOL)isNeedToRefreshTheToken;

//留给webview用
-(NSURL*)getOauthCodeUrl;

//获取登陆用户的UID
//-(void)getOpenID;

//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid;


//发布文字微博
-(void)postWithText:(NSString*)text;
@end
