//
//  CommentCell.h
//  DemoProject
//
//  Created by zj on 13-11-3.
//
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "HTTPMessageManager.h"

@interface CommentCell : UITableViewCell {
    UITextView *contentTV;
    UIImageView *userImage;
    UILabel *nameLabel;
    UILabel *timeLabel;
    UIButton *upButton;
    UIButton *downButton;
    UIButton *responseButton;
    
    HTTPMessageManager *manager;
    Comment *aComment;
    NSNumber *isVote;
    NSNumber *statusId;
}

@property (retain, nonatomic) IBOutlet UITextView *contentTV;
@property (retain, nonatomic) IBOutlet UIImageView *userImage;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIButton *upButton;
@property (retain, nonatomic) IBOutlet UIButton *downButton;
@property (retain, nonatomic) IBOutlet UIButton *responseButton;
@property (retain, nonatomic) Comment *aComment;
@property (retain, nonatomic) NSNumber *isVote;
@property (retain, nonatomic) NSNumber *statusId;

- (void)setUpCell:(Comment*)comment withData:(NSData*)headImage andStatusId:(NSNumber*)_statusId;

- (IBAction)upOrDown:(id)sender;
- (void)didPostUpOrDownCount:(NSNotification*)sender;
- (IBAction)responseToAComment:(id)sender;
- (void)didPostResponseToComment:(NSNotification*)sender;

@end
