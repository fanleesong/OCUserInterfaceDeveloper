//
//  LoginViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "Status.h"
#import "JSON.h"
#import "Comment.h"

@implementation LoginViewController
@synthesize requestQueue;
@synthesize delegate,userId;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
}

- (void)viewDidUnload
{
    [loginnameTextfield release];
    loginnameTextfield = nil;
    [codeTextfield release];
    codeTextfield = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    self.userId = nil;
    self.requestQueue = nil;
    
    [loginnameTextfield release];
    [codeTextfield release];
    [registerButton release];
    [super dealloc];
}
- (IBAction)loginButton:(id)sender {
    [self login];
}

- (IBAction)registerButton:(id)sender {
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
  
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    
    NSMutableDictionary     *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"c40fe2f61bcfd611177be71ec305196b",                       @"oauth_consumer_key",
                                       @"8F0C5943-3EB9-408B-82D7-199EB4D4FBA8",@"oauth_nonce",
                                       @"HMAC-SHA1",@"oauth_signature_method",
                                       @"1383881719",@"oauth_timestamp",
                                       @"1.0",@"oauth_version",
                                       @"client_auth",@"x_auth_model",
                                       codeTextfield.text,@"x_auth_password",
                                       [NSString stringWithFormat:@"%@40gozap.com",loginnameTextfield.text],@"x_auth_username",
                                       @"fS2QILO4UiX0vdgD2bFWAMfXsPE%3D",@"oauth_signature",
                                       nil];
    NSString  *baseUrl =[NSString  stringWithFormat:@" http://api.gozap.com/xauth/access_token"];
    NSURL *url = [self generateURL:baseUrl params:params];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"url=%@",url);
    [self setGetUserInfo:request withRequestType:ChoutiLogin];
    [requestQueue addOperation:request];
    [request release];
}

#pragma mark - ASINetworkQueueDelegate
//失败
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"requestFailed:%@,%@,",request.responseString,[request.error localizedDescription]);
}

//成功
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *userInformation = [request userInfo];
    ChoutiRequestType requestType = [[userInformation objectForKey:USER_INFO_KEY_TYPE] intValue];
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
    
}


@end
