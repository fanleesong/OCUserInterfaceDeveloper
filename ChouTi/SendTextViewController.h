//
//  SendTextViewController.h
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import <UIKit/UIKit.h>
#import "HTTPMessageManager.h"

@interface SendTextViewController : UIViewController<UITextViewDelegate>{
    
    IBOutlet UITextView *TextView;
    IBOutlet UILabel *TextcountLabael;
    int  remainTextNum;
    
    HTTPMessageManager *manager;
   
}

- (IBAction)keyboardButton:(id)sender;

- (IBAction)sendButton:(id)sender;
- (IBAction)selectButton:(id)sender;

@end
