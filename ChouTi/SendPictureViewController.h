//
//  SendPictureViewController.h
//  ChouTi
//
//  Created by hh on 13-11-5.
//
//

#import <UIKit/UIKit.h>
#import "HTTPMessageManager.h"

@interface SendPictureViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>{
    
    IBOutlet UITextView *TextView;
    IBOutlet UIImageView *imageView;
    UIImage *image;
    
    IBOutlet UILabel *TextcountLabael;
    int  remainTextNum;
    
    HTTPMessageManager *manager;
}

@property(retain,nonatomic)UIImageView *imageView;
@property(retain,nonatomic)UIImage *image;

- (IBAction)sendButton:(id)sender;
- (IBAction)selectButton:(id)sender;

@end
