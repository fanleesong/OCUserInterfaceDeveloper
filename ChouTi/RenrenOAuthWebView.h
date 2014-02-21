//
//  RenrenOAuthWebView.h
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import <UIKit/UIKit.h>
#import "RenrenMessagerManger.m"

@interface RenrenOAuthWebView : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *webView;
    NSString * token;
}
@property (nonatomic,retain)NSString * token;

@end
