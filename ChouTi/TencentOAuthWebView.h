//
//  TencentOAuthWebView.h
//  ChouTi
//
//  Created by administrator on 13-11-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalsetupViewController.h"
//#import "WeiBoMessageManager.h"

@interface TencentOAuthWebView : UIViewController<UIWebViewDelegate>{

    NSString *token;
    
    IBOutlet UIWebView *webView;
    
}
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *token;
@property (retain, nonatomic) NSString * lock;

@end
