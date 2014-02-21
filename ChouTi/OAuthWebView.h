//
//  OAuthWebView.h
//  test
//
//  Created by jianting zhu on 11-12-31.
//  Copyright (c) 2011年 Dunbar Science & Technology. All rights reserved.
//

#import "PersonalsetupViewController.h"
#import "WeiBoMessageManager.h"

@interface OAuthWebView : UIViewController<UIWebViewDelegate>{
    UIWebView *webV;
    NSString *token;
    
   
   }
@property (retain, nonatomic) IBOutlet UIWebView *webV;
@property (retain, nonatomic) NSString *token;
@property (retain, nonatomic) NSString * lock;

@end
