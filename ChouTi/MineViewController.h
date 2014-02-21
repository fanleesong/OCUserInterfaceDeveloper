//
//  MineViewController.h
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController{
    
    IBOutlet UILabel *saveLabel;
    IBOutlet UILabel *sendLabel;
    IBOutlet UILabel *recommendLabel;
    IBOutlet UILabel *commentLabel;
    
    NSDictionary *dic;
}

@property (retain, nonatomic)NSDictionary *dic;

- (IBAction)enterDetailVC:(id)sender;
- (IBAction)unLogin:(id)sender;

@end
