//
//  SendViewController.h
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import <UIKit/UIKit.h>

@interface SendViewController : UIViewController<UIAlertViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>{
    
}

- (IBAction)PictureButton:(id)sender;
- (IBAction)TextButton:(id)sender;

@end
