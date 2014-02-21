//
//  TabViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController : UIViewController<UITabBarControllerDelegate>{
    //UITabBarController * tabBarController;
    IBOutlet UIView *plusView;
    BOOL change;
}
- (IBAction)duanziButton:(id)sender;
- (IBAction)hotButton:(id)sender;

-(UINavigationController *)tabV;
@end
