//
//  WeiBoMessageManager.m
//  test
//
//  Created by jianting zhu on 11-12-31.
//  Copyright (c) 2011年 Dunbar Science & Technology. All rights reserved.
//

#import "WeiBoMessageManager.h"
#import "SinaStatus.h"
#import "SinaUser.h"

static WeiBoMessageManager * instance=nil;

@implementation WeiBoMessageManager
@synthesize httpManager;

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        httpManager = [[WeiBoHttpManager alloc] initWithDelegate:self];
        [httpManager start];
    }
    return self;
}

+(WeiBoMessageManager*)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[WeiBoMessageManager alloc] init];
        }
    }
    return instance;
}

- (BOOL)isNeedToRefreshTheToken
{
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults]objectForKey:USER_STORE_EXPIRATION_DATE];
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



//获取登陆用户的UID
-(void)getUserID
{
    [httpManager getUserID];
}

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


//转发一条微博
-(void)repost:(NSString*)weiboID content:(NSString*)content withComment:(int)isComment
{
    [httpManager repost:weiboID content:content withComment:isComment];
}

#pragma mark - WeiBoHttpDelegate

//获取登陆用户的UID
-(void)didGetUserID:(NSString *)userID
{
    NSLog(@"userID = %@",userID);
    NSNotification *notification = [NSNotification notificationWithName:MMSinaGotUserID object:userID];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//获取任意一个用户的信息
-(void)didGetUserInfo:(SinaUser *)user
{
    NSLog(@"userInfo = %@",user.screenName);
    NSNotification *notification = [NSNotification notificationWithName:MMSinaGotUserInfo object:user];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}





//发布微博
-(void)didGetPostResult:(SinaStatus *)sts
{
    NSLog(@"sts.text = %@",sts.text);
    NSNotification *notification = [NSNotification notificationWithName:MMSinaGotPostResult object:sts];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}




//转发一条微博
-(void)didRepost:(SinaStatus *)sts
{
    NSLog(@"sts.text = %@",sts.text);
    NSNotification *notification = [NSNotification notificationWithName:MMSinaGotRepost object:sts];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
