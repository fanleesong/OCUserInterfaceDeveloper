//
//  TwitterVC.h
//  zjtSinaWeiboClient
//
//  Created by Zhu Jianting on 12-3-14.
//  Copyright (c) 2012年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoMessageManager.h"
#import "TencentMessageManger.h"
//@class WeiBoMessageManager;
//@class TencentMessageManger;

@interface TwitterVC : UIViewController<UINavigationControllerDelegate>
{
    WeiBoMessageManager *manager;
    TencentMessageManger * tencentManager;
    IBOutlet UILabel *showLabel;
}
@property (retain, nonatomic) IBOutlet UIScrollView *theScrollView;


@property (retain, nonatomic) IBOutlet UITextView *theTextView;
- (IBAction)shareButton:(id)sender;

@end
