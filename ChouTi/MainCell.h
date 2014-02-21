//
//  MainCell.h
//  DemoProject
//
//  Created by zj on 13-11-3.
//
//

#import <UIKit/UIKit.h>
#import "HTTPMessageManager.h"
#import "HomePageVC.h"
#import "Status.h"
#import "User.h"

@interface MainCell : UITableViewCell {
    HTTPMessageManager *manager;
    HomePageVC *delegate;
    User *user;
    Status *aStatus;
    NSInteger index;
    BOOL isUp;
    
    UITextView *content;
    UIImageView *contentImageView;
    UILabel *userName;
    UILabel *submittedTime;
    UIButton *upButton;
    UIImageView *commentImage;
    UIButton *commentButton;
    UIImageView *upImage;
    }

@property (retain, nonatomic) IBOutlet UIImageView *upImage;
@property (retain, nonatomic) IBOutlet UIButton *upButton;
@property (retain, nonatomic) IBOutlet UIImageView *commentImage;
@property (retain, nonatomic) IBOutlet UIButton *commentButton;
@property (retain, nonatomic) User *user;
@property (retain, nonatomic) Status *aStatus;
@property (assign, nonatomic) NSInteger index;
@property (retain, nonatomic) IBOutlet UITextView *content;
@property (retain, nonatomic) IBOutlet UIImageView *contentImageView;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *submittedTime;
@property (retain, nonatomic) HomePageVC *delegate;

- (void)setUpCell:(Status*)status withSubjectType:(SubjectType)subjectType andImage:(NSData*)image;
- (IBAction)comment:(id)sender;
- (IBAction)isUp:(id)sender;
- (void)up;
- (void)cancelUp;
- (void)didGetUpMessage:(NSNotification*)sender;
- (void)didGetCancelUpMessag:(NSNotification*)sender;


@end
