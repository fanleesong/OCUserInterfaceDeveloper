//
//  MainViewController.h
//  WeiCo
//
//  Created by 范林松 on 14-2-25.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface MainViewController : UITabBarController<SinaWeiboDelegate>

{
    UIView *_tabbarView;

}

@end
