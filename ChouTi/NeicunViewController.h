//
//  NeicunViewController.h
//  ChouTi
//
//  Created by administrator on 13-11-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NeicunViewController : UIViewController{
    
    IBOutlet UILabel *neicunCountLabel;
    IBOutlet UILabel *descripLabel;

}
- (IBAction)clearButton:(id)sender;
- (IBAction)historyButton:(id)sender;
- (unsigned long long)fileSizeAtPath:(NSString*) filePath;
@end
