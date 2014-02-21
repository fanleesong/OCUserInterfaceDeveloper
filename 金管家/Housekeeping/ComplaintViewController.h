//
//  ComplaintViewController.h
//  HorseKeeping
//
//  Created by OldHorse on 13-4-2.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRConstants.h"
#import "KRHttpUtil.h"

@interface ComplaintViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UITextField *StaffID;
@property (nonatomic, retain) IBOutlet UITextView  *ComplaintText;


-(IBAction)CLearKeyBoard:(id)sender;
-(IBAction)BackView:(id)sender;
-(IBAction)Submit:(id)sender;

@end
