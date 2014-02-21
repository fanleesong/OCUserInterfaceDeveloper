//
//  NormalCommentAssistVC.h
//  DemoProject
//
//  Created by administrator on 13-11-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "HTTPMessageManager.h"

@interface NormalCommentAssistVC : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView *myTableView;
    UITextField *myCommentTV;
    UILabel *upCount;
    UIView *headerView;
    UIImageView *headerBackImage;
    UITextView *contentTV;
    UIImageView *contentImage;
    UIButton *refreshButton;
    
    HTTPMessageManager *manager;
    Status *status;
    BOOL isUp;
    BOOL isSave;
    NSArray *ids;
    NSArray *commentsArr;
    NSMutableDictionary *headDictionary;
    BOOL fontType;
    
}

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UITextField *myCommentTV;
@property (retain, nonatomic) IBOutlet UILabel *upCount;
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet UIImageView *headerBackImage;
@property (retain, nonatomic) IBOutlet UITextView *contentTV;
@property (retain, nonatomic) IBOutlet UIImageView *contentImage;
@property (retain, nonatomic) IBOutlet UIButton *refreshButton;
@property (retain, nonatomic) Status *status;
@property (retain, nonatomic) NSArray *ids;
@property (retain, nonatomic) NSArray *commentsArr;
@property (retain, nonatomic) NSMutableDictionary *headDictionary;

- (void)didGetCommentIds:(NSNotification*)sender;
- (void)didGetCommentList:(NSNotification*)sender;
- (void)getHeadImages;
- (void)didGetHeadImages:(NSNotification*)sender;
- (void)getImage;
- (void)didGetImage:(NSNotification*)sender;

- (IBAction)isUp:(id)sender;
- (void)didPostUpMessage:(NSNotification*)sender;
- (void)didPostCancelUpMessage:(NSNotification*)sender;
- (IBAction)isSave:(id)sender;
- (void)didPostSaveMessage:(NSNotification*)sender;
- (void)didPostCancelSaveMessage:(NSNotification*)sender;
- (IBAction)shareTo:(id)sender;
- (IBAction)refreshCommentsList:(id)sender;

@end
