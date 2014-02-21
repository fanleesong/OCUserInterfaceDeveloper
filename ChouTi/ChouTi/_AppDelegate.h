//
//  _AppDelegate.h
//  ChouTi
//
//  Created by administrator on 13-10-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuViewController.h"

@interface _AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate> {

    MenuViewController *menu;
}

@property (retain, nonatomic) MenuViewController * menu;
@property (strong, nonatomic) UIWindow *window;

@end
