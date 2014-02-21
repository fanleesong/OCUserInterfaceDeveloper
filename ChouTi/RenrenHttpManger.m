//
//  RenrenHttpManger.m
//  ChouTi
//
//  Created by user on 13-11-9.
//
//

#import "RenrenHttpManger.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "Status.h"
#import "JSON.h"

@implementation RenrenHttpManger
@synthesize requestQueue;
@synthesize delegate;
@synthesize authCode;
@synthesize authToken;


-(void)dealloc
{
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
- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(RenrenRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:RENREN_INFO_KEY_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(RenrenRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:RENREN_INFO_KEY_TYPE];
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
                                   RENREN_APP_KEY,    @"client_id",   //申请的appkey
                                   @"code",    @"response_type",   //access_token
                                   RENREN_REDIRECTURL,   @"redirect_uri",    //申请时的重定向地址
                                    @"mobile",    @"display",         //web页面的显示方式
                                   nil];

	NSURL *url = [self generateURL:RENREN_API_AUTHRIZE params:params];
	NSLog(@"webview : url= %@",url);
    return url;
}


/*
 //获取登陆用户的UID
 -(void)getOpenID
 {

 self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:RENREN_STORE_ACCESS_TOKEN];
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

    NSMutableDictionary  *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    RENREN_STORE_ACCESS_TOKEN,   @"access_token",
                                    RENREN_STORE_USER_ID,@"userId",
                                                nil];
    NSString *baseUrl =[NSString  stringWithFormat:@"https://api.renren.com/v2/user/get"];
    NSURL *url = [self generateURL:baseUrl params:params];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"UserInfo : url=%@",url);
    [self setGetUserInfo:request withRequestType:RenrenGetUserInfo];
    [requestQueue addOperation:request];
    [request release];
}
/*
//发布文字
-(void)postWithText:(NSString*)text
{
    //https://open.t.qq.com/api/t/add

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

    [request setPostValue:text forKey:@"content"];
    [self setPostUserInfo:request withRequestType:PostText];
    [requestQueue addOperation:request];
    [request release];
}

*/
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
    RenrenRequestType requestType = [[userInformation objectForKey:RENREN_INFO_KEY_TYPE] intValue];
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
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:RENREN_STORE_ACCESS_TOKEN];
        
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



    //获取用户的信息
    if (requestType == RenrenGetUserInfo) {
        User *user = [[User alloc]initWithJsonDictionary:userInfo];
        if ([delegate respondsToSelector:@selector(didGetTencentUserInfo:)]) {
            [delegate didGetTencentUserInfo:user];
        }
        [user release];
    }

    //发布
    if (requestType == RenrenPostText) {
        Status* sts = [Status statusWithJsonDictionary:userInfo];
        if ([delegate respondsToSelector:@selector(didGetPostResult:)]) {
            [delegate didGetPostResult:sts];
        }
    }

}

//跳转
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL {
    NSLog(@"request will redirect");
    NSNotification *notification = [NSNotification notificationWithName:RequestFailed object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


@end
