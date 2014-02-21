//
//  WeiBoHttpManager.m
//  test
//
//  Created by jianting zhu on 11-12-31.
//  Copyright (c) 2011年 Dunbar Science & Technology. All rights reserved.
//

#import "WeiBoHttpManager.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "SinaStatus.h"
#import "JSON.h"

@implementation WeiBoHttpManager
@synthesize requestQueue;
@synthesize delegate;
@synthesize authCode;
@synthesize authToken;
@synthesize userId;

#pragma mark - Init

-(void)dealloc
{
    self.userId = nil;
    self.authToken = nil;
    self.authCode = nil;
    self.requestQueue = nil;
    [super dealloc];
}

//初始化
- (id)initWithDelegate:(id)theDelegate {
    self = [super init];
    if (self) {
        requestQueue = [[ASINetworkQueue alloc] init];
        [requestQueue setDelegate:self];
        [requestQueue setRequestDidFailSelector:@selector(requestFailed:)];
        [requestQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [requestQueue setRequestWillRedirectSelector:@selector(request:willRedirectToURL:)];
		[requestQueue setShouldCancelAllRequestsOnFailure:NO];
        [requestQueue setShowAccurateProgress:YES];
        self.delegate = theDelegate;
    }
    return self;
}

#pragma mark - Methods
- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(SinnaRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:USER_INFO_KEY_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(SinnaRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:USER_INFO_KEY_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
	if (params) {
		NSMutableArray* pairs = [NSMutableArray array];
		for (NSString* key in params.keyEnumerator) {
			NSString* value = [params objectForKey:key];
			NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																						  NULL, /* allocator */
																						  (CFStringRef)value,
																						  NULL, /* charactersToLeaveUnescaped */
																						  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						  kCFStringEncodingUTF8);

            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
			[escaped_value release];
		}
		
		NSString* query = [pairs componentsJoinedByString:@"&"];
		NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
		return [NSURL URLWithString:url];
	} else {
		return [NSURL URLWithString:baseURL];
	}
}

//提取用户ID
- (NSString *) extractUsernameFromHTTPBody: (NSString *) body {
	if (!body) {
        return nil;
    }
	
	NSArray	*tuples = [body componentsSeparatedByString: @"&"];
	if (tuples.count < 1) {
        return nil;
    }
	
	for (NSString *tuple in tuples) {
		NSArray *keyValueArray = [tuple componentsSeparatedByString: @"="];
		
		if (keyValueArray.count == 2) {
			NSString    *key = [keyValueArray objectAtIndex: 0];
			NSString    *value = [keyValueArray objectAtIndex: 1];
			
			if ([key isEqualToString:@"screen_name"]) return value;
			if ([key isEqualToString:@"user_id"]) return value;
		}
	}
	return nil;
}

#pragma mark - Http Operate
//获取auth_code or access_token
-(NSURL*)getOauthCodeUrl //留给webview用
{
    //https://api.weibo.com/oauth2/authorize
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   SINA_APP_KEY,                    @"client_id",       //申请的appkey
								   @"token",                        @"response_type",   //access_token
								   REDIRECT_URL,   @"redirect_uri",    //申请时的重定向地址
								   @"mobile",                       @"display",         //web页面的显示方式
                                   nil];
	
	NSURL *url = [self generateURL:SINA_API_AUTHORIZE params:params];
	NSLog(@"url= %@",url);
    return url;
}



//获取登陆用户的UID
-(void)getUserID
{
    //https://api.weibo.com/2/account/get_uid.json
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Sinna_USER_STORE_ACCESS_TOKEN];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       authToken,   @"access_token",
                                       nil];
    NSString                *baseUrl = [NSString  stringWithFormat:@"%@/account/get_uid.json",SINA_V2_DOMAIN];
    NSURL                   *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:SinnaGetUserID];
    [requestQueue addOperation:request];
    [request release];
}

//获取用户的信息
-(void)getUserInfoWithUserID:(long long)uid
{
    //https://api.weibo.com/2/users/show.json
    
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Sinna_USER_STORE_ACCESS_TOKEN];
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       authToken,                                   @"access_token",
                                       [NSString stringWithFormat:@"%lld",uid],     @"uid",
                                       nil];
    NSString                *baseUrl =[NSString  stringWithFormat:@"%@/users/show.json",SINA_V2_DOMAIN];
    NSURL                   *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:SinnaGetUserInfo];
    [requestQueue addOperation:request];
    [request release];
}


//发布文字微博
-(void)postWithText:(NSString*)text
{
    //https://api.weibo.com/2/statuses/update.json
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Sinna_USER_STORE_ACCESS_TOKEN];
    
    [item setPostValue:authToken    forKey:@"access_token"];
    [item setPostValue:text         forKey:@"status"];
    
    [self setPostUserInfo:item withRequestType:SinnaPostText];
    [requestQueue addOperation:item];
    [item release];
}


#pragma mark - Operate queue
- (BOOL)isRunning
{
	return ![requestQueue isSuspended];
}

- (void)start
{
	if( [requestQueue isSuspended] )
		[requestQueue go];
}

- (void)pause
{
	[requestQueue setSuspended:YES];
}

- (void)resume
{
	[requestQueue setSuspended:NO];
}

- (void)cancel
{
	[requestQueue cancelAllOperations];
}

#pragma mark - ASINetworkQueueDelegate
//失败
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"requestFailed:%@,%@,",request.responseString,[request.error localizedDescription]);
}

//成功
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *userInformation = [request userInfo];
    SinnaRequestType requestType = [[userInformation objectForKey:USER_INFO_KEY_TYPE] intValue];
    NSString * responseString = [request responseString];
    NSLog(@"responseString = %@",responseString);

    SBJsonParser  *parser = [[SBJsonParser alloc] init];    
    id  returnObject = [parser objectWithString:responseString];
    [parser release];
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        NSString *errorString = [returnObject  objectForKey:@"error"];
        if (errorString != nil && ([errorString isEqualToString:@"auth faild!"] || 
                                   [errorString isEqualToString:@"expired_token"] || 
                                   [errorString isEqualToString:@"invalid_access_token"])) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NeedToReLogin object:nil];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:Sinna_USER_STORE_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_USER_ID];
            NSLog(@"detected auth faild!");
        }
    }
    
    NSDictionary *userInfo = nil;
    NSArray *userArr = nil;
    if ([returnObject isKindOfClass:[NSDictionary class]]) {
        userInfo = (NSDictionary*)returnObject;
         NSLog(@"userinfo = ***************%@",userInfo);
    }
    else if ([returnObject isKindOfClass:[NSArray class]]) {
        userArr = (NSArray*)returnObject;
    }
    else {
        return;
    }
    
    
      //获取登陆用户ID
    if (requestType == SinnaGetUserID) {
        NSLog(@"login: userinfo = %@",userInfo );
        NSNumber *userID = [userInfo objectForKey:@"uid"];
        self.userId = [NSString stringWithFormat:@"%@",userID];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_STORE_USER_ID];
//       NSNumber *userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
//       self.userId = [NSString stringWithFormat:@"%@",userID];  
        if ([delegate respondsToSelector:@selector(didGetUserID:)]) {
            [delegate didGetUserID:userId];
        }
    }
    
    //获取用户的信息
    if (requestType == SinnaGetUserInfo) {
        SinaUser *user = [[SinaUser alloc]initWithJsonDictionary:userInfo];
        if ([delegate respondsToSelector:@selector(didGetUserInfo:)]) {
            [delegate didGetUserInfo:user];
        }
        [user release];
    }
    
      //发布
    if (requestType == SinnaPostText) {
        SinaStatus* sts = [SinaStatus statusWithJsonDictionary:userInfo];
        if ([delegate respondsToSelector:@selector(didGetPostResult:)]) {
            [delegate didGetPostResult:sts];
        }
    }
    
}

//跳转
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL {
    NSLog(@"request will redirect");
    NSNotification *notification = [NSNotification notificationWithName:MMSinaRequestFailed object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
