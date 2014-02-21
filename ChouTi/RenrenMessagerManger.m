//
//  RenrenMessagerManger.m
//  ChouTi
//
//  Created by user on 13-11-9.
//
//

#import "RenrenMessagerManger.h"
#import "SinaStatus.h"

static RenrenMessagerManger *instance = nil;

@implementation RenrenMessagerManger
@synthesize manger;

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        manger = [[RenrenHttpManger alloc] initWithDelegate:self];
        [manger start];
    }
    return self;
}

+(RenrenMessagerManger*)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[RenrenMessagerManger alloc] init];
        }
    }
    return instance;
}

- (BOOL)isNeedToRefreshTheToken
{
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults]objectForKey:RENREN_STORE_EXPIRATION_DATE];
    if (expirationDate == nil)  return YES;

    BOOL boolValue1 = !(NSOrderedDescending == [expirationDate compare:[NSDate date]]);
    BOOL boolValue2 = (expirationDate != nil);

    return (boolValue1 && boolValue2);
}

#pragma mark - Http Methods
//留给webview用
-(NSURL*)getOauthCodeUrl
{
    return [manger getOauthCodeUrl];
}

/*

//获取登陆用户的UID
-(void)getUserID
{
    [manger getUserID];
}
 */

//获取任意一个用户的信息
-(void)getUserInfoWithUserID:(long long)uid
{
    [manger getUserInfoWithUserID:uid];
}






//发布文字微博
-(void)postWithText:(NSString*)text
{
    [manger postWithText:text];
}


#pragma mark - WeiBoHttpDelegate

//获取登陆用户的UID
-(void)didGetUserID:(NSString *)userID
{
    NSLog(@"userID = %@",userID);
    NSNotification *notification = [NSNotification notificationWithName:GotUserID object:userID];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//获取任意一个用户的信息
-(void)didGetUserInfo:(SinaUser *)user
{
   // NSLog(@"userInfo = %@",user.screenName);
    NSNotification *notification = [NSNotification notificationWithName:GotUserInfo object:user];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}





//发布微博
-(void)didGetPostResult:(SinaStatus *)sts
{
    NSLog(@"sts.text = %@",sts.text);
    NSNotification *notification = [NSNotification notificationWithName:GotPostResult object:sts];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
