//
//  MainOAuhViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenrenMessagerManger.m"

@interface MainOAuhViewController : UIViewController<UIWebViewDelegate>{
  
    IBOutlet UIWebView *webView;
    NSString * token;
}
@property (nonatomic,retain)NSString * token;

@end
