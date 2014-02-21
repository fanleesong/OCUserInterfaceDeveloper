//
//  TencentMessageManger.m
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TencentMessageManger.h"
#import "SinaStatus.h"
#import "SinaUser.h"

static TencentMessageManger * instance=nil;
@implementation TencentMessageManger
@synthesize httpManager;

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        httpManager = [[TencentHttpManger alloc] initWithDelegate:self];
        [httpManager start];
    }
    return self;
}

+(TencentMessageManger*)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[TencentMessageManger alloc] init];
        }
    }
    return instance;
}

- (BOOL)isNeedToRefreshTheToken
{
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults]objectForKey:Tencen_STORE_EXPIRATION_DATE];
    if (expirationDate == nil)  return YES;
    
    BOOL boolValue1 = !(NSOrderedDescending == [expirationDate compare:[NSDate date]]);
    BOOL boolValue2 = (expirationDate != nil);
    
    return (boolValue1 && boolValue2);
}

#pragma mark - Http Methods
//留给webview用
-(NSURL*)getOauthCodeUrl
{
    return [httpManager getOauthCodeUrl];
}


/*
//获取登陆用户的UID
-(void)getOpenID
{
    [httpManager getOpenID];
}
*/


//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid
{
    [httpManager getUserInfoWithUserID:uid];
}






//发布文字微博
-(void)postWithText:(NSString*)text
{

    [httpManager postWithText:text];
}



#pragma mark - WeiBoHttpDelegate

//获取登陆用户的UID
-(void)didGetOpenID:(NSString *)OpenID
{
   
    NSNotification *notification = [NSNotification notificationWithName:TencentGotOpenID object:OpenID];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)didGetOpenKey:(NSString *)OpenKey{
    NSNotification *notification = [NSNotification notificationWithName:TencentGotOpenKey object:OpenKey];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


//获取任意一个用户的信息
-(void)didGetTencentUserInfo:(SinaUser *)user
{
    NSLog(@"userInfo = %@",user.screenName);
    NSNotification *notification = [NSNotification notificationWithName:TencentGotUserInfo object:user];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


//发布微博
-(void)didGetPostResult:(SinaStatus *)sts
{
    NSLog(@"sts.text = %@",sts.text);
    NSNotification *notification = [NSNotification notificationWithName:TencentGotPostResult object:sts];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}




@end
