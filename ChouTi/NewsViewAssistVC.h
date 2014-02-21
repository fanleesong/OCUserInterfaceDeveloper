//
//  NewsViewAssistVC.h
//  DemoProject
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageVC.h"
#import "AssistMineVC.h"

@interface NewsViewAssistVC : UIViewController <UIWebViewDelegate>{
    UIWebView *webView;
    NSString *url;
    NSInteger index;
    HomePageVC *delegate;
    AssistMineVC *dele;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *url;
@property (assign, nonatomic) NSInteger index;
@property (retain, nonatomic) HomePageVC *delegate;
@property (retain, nonatomic) AssistMineVC *dele;

- (IBAction)enterCommentsView:(id)sender;

@end
