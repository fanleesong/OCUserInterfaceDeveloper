//
//  WeiBoMessageManager.h
//  test
//
//  Created by jianting zhu on 11-12-31.
//  Copyright (c) 2011年 Dunbar Science & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiBoHttpManager.h"


//获取登陆用户的UID
//返回userID(NSString)
#define MMSinaGotUserID @"MMSinaGotUserID"

//获取任意一个用户的信息
//返回一个User对象
#define MMSinaGotUserInfo @"MMSinaGotUserInfo"

//发布微博
//返回一个Status对象
#define MMSinaGotPostResult @"MMSinaGotPostResult"

//转发一条微博
//返回一个Status对象
#define MMSinaGotRepost @"MMSinaGotRepost"

@interface WeiBoMessageManager : NSObject <WeiBoHttpDelegate>
{
    WeiBoHttpManager *httpManager;
}
@property (nonatomic,retain)WeiBoHttpManager *httpManager;

+(WeiBoMessageManager*)getInstance;

//查看Token是否过期
- (BOOL)isNeedToRefreshTheToken;

//留给webview用
-(NSURL*)getOauthCodeUrl;

//获取登陆用户的UID
-(void)getUserID;

//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid;


//发布文字微博
-(void)postWithText:(NSString*)text;





@end
