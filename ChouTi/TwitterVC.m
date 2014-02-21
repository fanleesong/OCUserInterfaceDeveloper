//
//  TwitterVC.m
//  zjtSinaWeiboClient
//
//  Created by Zhu Jianting on 12-3-14.
//  Copyright (c) 2012年 WS. All rights reserved.
//

#import "TwitterVC.h"

#import "Status.h"
#import "OAuthWebView.h"
#import "TencentOAuthWebView.h"
static NSString *userID;
static NSString * openID;

@interface TwitterVC ()

@end

@implementation TwitterVC

@synthesize theScrollView;
@synthesize theTextView;



#pragma mark - Lifecycle
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    }
    return self;
}
*/
- (void)dealloc {
    [theScrollView release];
    [theTextView release];
    [showLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    theScrollView.contentSize = CGSizeMake(320, 410);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPost:) name:MMSinaGotPostResult object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPost:) name:TencentGotPostResult object:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
    openID = [[NSUserDefaults standardUserDefaults] objectForKey:Tencen_STORE_OPEN_ID];
    if (userID !=nil) {
        manager = [WeiBoMessageManager getInstance];
        showLabel.text = @"已绑定新浪微博！";
         showLabel.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:18];
    }
    else if ( openID !=nil) {
        tencentManager  = [TencentMessageManger getInstance];
        showLabel.text = @"已绑定腾讯微博！";
        showLabel.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:18];
    }
    else{
        showLabel.text = @"请先绑定帐号！";
    }
    [super viewWillAppear:animated];
    [theTextView becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated 
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
   
    [self setTheScrollView:nil];
    [self setTheTextView:nil];
    [showLabel release];
    showLabel = nil;
    [super viewDidUnload];
}

-(void)didPost:(NSNotification*)sender
{
    NSString *content = theTextView.text;
    if (content != nil && [content length] != 0) {
       // [[ZJTStatusBarAlertWindow getInstance] hide];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (IBAction)shareButton:(id)sender {
    NSString *content = theTextView.text;
    if (content != nil && [content length] != 0) {
        if (userID !=nil) {
            [manager postWithText:content];            
        }
        if ( openID !=nil) {
            [tencentManager postWithText:content];
           
        }

    }

}

@end
