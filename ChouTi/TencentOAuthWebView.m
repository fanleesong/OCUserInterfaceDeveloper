//
//  TencentOAuthWebView.m
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TencentOAuthWebView.h"
#import "TencentHttpManger.h"
#import "TencentMessageManger.h"
#import "SHKActivityIndicator.h"
#import "ZJTHelpler.h"
//#import "ZJTStatusBarAlertWindow.h"




@implementation TencentOAuthWebView
@synthesize webView;
@synthesize token,lock;

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

- (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle {
	NSString * str = nil;
	NSRange start = [url rangeOfString:needle];
	if (start.location != NSNotFound) {
		NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
		NSUInteger offset = start.location+start.length;
		str = end.location == NSNotFound
		? [url substringFromIndex:offset]
		: [url substringWithRange:NSMakeRange(offset, end.location)];
		str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	return str;
}

//剥离出url中的access_token的值
- (void) dialogDidSucceed:(NSURL*)url {
    NSString *q = [url absoluteString];
    NSLog(@"q = ===================%@",q);
    token = [self getStringFromUrl:q needle:@"access_token="];
    //用户点取消 error_code=21330
    NSString *errorCode = [self getStringFromUrl:q needle:@"error_code="];
    if (errorCode != nil && [errorCode isEqualToString: @"21330"]) {
        NSLog(@"Oauth canceled");
    }
    
    NSString *refreshToken  = [self getStringFromUrl:q needle:@"refresh_token="];
    NSString *expTime       = [self getStringFromUrl:q needle:@"expires_in="];
    NSString * openID = [self getStringFromUrl:q needle:@"openid="];
    NSString * openKEY = [self getStringFromUrl:q needle:@"openkey"];
    NSString *remindIn = [self getStringFromUrl:q needle:@"remind_in="];
    
   // NSLog(@"userID = %@", uid);
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:Tencen_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:openID forKey:Tencen_STORE_OPEN_ID];
    [[NSUserDefaults standardUserDefaults] setObject:openKEY forKey:Tencen_STORE_OPEN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDate *expirationDate =nil;
    NSLog(@"jtone \n\ntoken=%@\nrefreshToken=%@\nexpTime=%@\nopenID=%@\nopenKEY=%@\nremindIn=%@\n\n",token,refreshToken,expTime,openID,openKEY,remindIn);
    if (expTime != nil) {
        int expVal = [expTime intValue]-3600;
        if (expVal == 0) 
        {
            
        } else {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
            [[NSUserDefaults standardUserDefaults]setObject:expirationDate forKey:USER_STORE_EXPIRATION_DATE];
            [[NSUserDefaults standardUserDefaults] synchronize];
			NSLog(@"jtone time = %@",expirationDate);
        } 
    } 
    
    if (token) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DID_GET_TOKEN_IN_WEB_VIEW object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.title = @"登陆";
    //self.navigationItem.hidesBackButton = YES;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Tencen_STORE_OPEN_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_STORE_EXPIRATION_DATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    webView.delegate = self;
    TencentHttpManger *weiboHttpManager = [[TencentHttpManger alloc]initWithDelegate:self];
    NSURL *url = [weiboHttpManager getOauthCodeUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    [request release];
    [weiboHttpManager release];
    
    
}


- (void)viewDidUnload
{
    [webView release];
    webView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	//这里是几个重定向，将每个重定向的网址遍历，如果遇到＃号，则重定向到自己申请时候填写的网址，后面会附上access_token的值
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = nil;
    for (UIWindow *win in app.windows) {
        if (win.tag == 1) {
            window = win;
            window.windowLevel = UIWindowLevelNormal;
        }
        if (win.tag == 0) {
            [win makeKeyAndVisible];
        }
    }
    
	NSURL *url = [request URL];
    NSLog(@"webview's url = %@",url);
	NSArray *array = [[url absoluteString] componentsSeparatedByString:@"#"];
	if ([array count]>1) {
		[self dialogDidSucceed:url];
		return NO;
	}
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:self.view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[SHKActivityIndicator currentIndicator] hide];
    //    [[ZJTStatusBarAlertWindow getInstance] hide];
}


- (void)dealloc {
    [webView release];
    [super dealloc];
}
@end
