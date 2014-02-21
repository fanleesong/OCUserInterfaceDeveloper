//
//  TencentHttpManger.m
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TencentHttpManger.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "SinaStatus.h"
#import "JSON.h"



@implementation TencentHttpManger
@synthesize requestQueue;
@synthesize delegate;
@synthesize authCode;
@synthesize authToken;
@synthesize openId,openKey;

-(void)dealloc
{
    self.openId = nil;
    self.authToken = nil;
    self.authCode = nil;
    self.requestQueue = nil;
    [super dealloc];
}



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



#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Methods
- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(RequestTypee)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:Tencen_INFO_KEY_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(RequestTypee)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:Tencen_INFO_KEY_TYPE];
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
        // https://open.t.qq.com/cgi-bin/oauth2/authorize  
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   TENCENT_APP_KEY,    @"client_id",   //申请的appkey
                                   @"token",    @"response_type",   //access_token
                                REDIRECTURL,   @"redirect_uri",    //申请时的重定向地址 
                                   nil];
	
	NSURL *url = [self generateURL:TENCENT_API_AUTHORIZE params:params];
	NSLog(@"webview : url= %@",url);
    return url;
}


/*
//获取登陆用户的UID
-(void)getOpenID
{
    
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_ACCESS_TOKEN];
    //self.openId = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_ID];
   // self.openKey = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_KEY];
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     authToken,   @"access_token",                                       nil];
    NSString                *baseUrl = [NSString  stringWithFormat:@"%@user/uid",TENCENT_V2_DOMAIN];
    NSURL                   *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:GetOpenID];
    [requestQueue addOperation:request];
    [request release];
}
*/

//获取用户的信息
-(void)getUserInfoWithUserID:(long long)uid
{
   
    //https://open.t.qq.com/api/user/info
    //https://api.weibo.com/2/users/show.json

    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_ACCESS_TOKEN];
    self.openId = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_ID];
    self.openKey = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_KEY];
    
    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     authToken,   @"access_token",
                                       openId,  @"openid",
                                    openKey,@"openkey",
                                    Format,@"format",
                                       nil];
    NSString                *baseUrl =[NSString  stringWithFormat:@"%@user/info?scope=all",TENCENT_V2_DOMAIN];
    NSURL                   *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"UserInfo : url=%@",url);
    [self setGetUserInfo:request withRequestType:GetUserInfo];
    [requestQueue addOperation:request];
    [request release];
}
//发布文字
-(void)postWithText:(NSString*)text
{
    //https://open.t.qq.com/api/t/add
    
    self.openId = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_ID];
    self.openKey = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_KEY];
    self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_ACCESS_TOKEN];
     NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     CLIENTIP,@"clientip",
                                     authToken,   @"access_token",
                                    openKey,@"openkey", 
                                     openId,@"openid",
                                     Format,@"format",
                                    nil];
    NSString                *baseUrl =[NSString  stringWithFormat:@"%@t/add",TENCENT_V2_DOMAIN];
    
    NSURL                   *url = [self generateURL:baseUrl params:params];
    NSLog(@"postText : URL = %@",url);
    //NSURL *url = [NSURL URLWithString:@"https://open.t.qq.com/api/t/add"];
    ASIFormDataRequest * request = [[ASIFormDataRequest alloc]initWithURL:url];
    NSLog(@"content = %@",text);
    [request setPostValue:text forKey:@"content"];
    [self setPostUserInfo:request withRequestType:PostTxt];
    [requestQueue addOperation:request];
    [request release];
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
    RequestTypee requestType = [[userInformation objectForKey:Tencen_INFO_KEY_TYPE] intValue];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:Tencen_NeedToReLogin object:nil];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_OPEN_KEY];
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
    if (requestType == GetOpenID ) {
        NSNumber *openid = [userInfo objectForKey:@"openid"];
        NSNumber * openkey = [userInfo objectForKey:@"openkey"];
        self.openId = [NSString stringWithFormat:@"%@",openid];
        self.openKey = [NSString stringWithFormat:@"%@",openkey];
        [[NSUserDefaults standardUserDefaults] setObject:openId forKey:Tencen_STORE_OPEN_ID];
        [[NSUserDefaults standardUserDefaults] setObject:openKey forKey:Tencen_STORE_OPEN_KEY];
        if ([delegate respondsToSelector:@selector(didGetUserID:)]) {
            [delegate didGetOpenID:openId];
        }
    }
    
    //获取用户的信息
    if (requestType == GetUserInfo) {
        SinaUser *user = [[SinaUser alloc]initWithJsonDictionary:userInfo];
        if ([delegate respondsToSelector:@selector(didGetTencentUserInfo:)]) {
            [delegate didGetTencentUserInfo:user];
        }
        [user release];
    }
    
    //发布
    if (requestType == PostTxt) {
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
