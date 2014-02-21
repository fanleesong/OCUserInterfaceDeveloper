//
//  ChoutiHttpManager.m
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import "ChoutiHttpManager.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "Status.h"
#import "JSON.h"
#import "Comment.h"

@implementation ChoutiHttpManager
@synthesize requestQueue;
@synthesize delegate,userId;

-(void)dealloc
{
    self.userId = nil;
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
- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(ChoutiRequestType)requestType {
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:USER_INFO_KEY_TYPE];
    [request setUserInfo:dict];
    [dict release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(ChoutiRequestType)requestType {
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

//获取用户的信息
-(void)login
{
    //http://api.gozap.com/xauth/access_token
    
    //self.authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_ACCESS_TOKEN];
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    
   NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"c40fe2f61bcfd611177be71ec305196b",                       @"oauth_consumer_key",
                                      @"8F0C5943-3EB9-408B-82D7-199EB4D4FBA8",@"oauth_nonce",
                                      @"HMAC-SHA1",@"oauth_signature_method",
                                      @"1383881719",@"oauth_timestamp",
                                       @"1.0",@"oauth_version",
                                      @"client_auth",@"x_auth_model",
                                      @"",@"",
                                       nil];
    NSString  *baseUrl =[NSString  stringWithFormat:@"http://api.gozap.com/xauth/access_token"];
    NSURL *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:ChoutiGetUserInfo];
    [requestQueue addOperation:request];
    [request release];
}


@end
