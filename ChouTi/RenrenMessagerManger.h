//
//  RenrenMessagerManger.h
//  ChouTi
//
//  Created by user on 13-11-9.
//
//

#import <Foundation/Foundation.h>
#import "RenrenHttpManger.h"

#define GotUserID       @"GotUserID"
#define GotUserInfo     @"GotUserInfo"
#define GotPostResult   @"GotPostResult"


@interface RenrenMessagerManger : NSObject<RenrenHttpDelegate>{
    RenrenHttpManger * manger;
}
@property (nonatomic,retain)RenrenHttpManger * manger;

+(RenrenMessagerManger *)getInstance;
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
