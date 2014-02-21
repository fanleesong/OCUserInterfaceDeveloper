//
//  NewsViewAssistVC.m
//  DemoProject
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewAssistVC.h"

@implementation NewsViewAssistVC
@synthesize webView;
@synthesize url;
@synthesize index;
@synthesize delegate;
@synthesize dele;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *realUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:realUrl];
    [webView loadRequest:request];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [webView release];
    [super dealloc];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp{
    
    return YES;
}

#pragma mark - ButtonMethods

- (IBAction)enterCommentsView:(id)sender {
    if([dele respondsToSelector:@selector(pushComments:)]){
        [dele pushComments:index];
    }
    if([delegate respondsToSelector:@selector(pushCommentsView:)]){
        [delegate pushCommentsView:index];
    }
}
@end
