//
//  CommentCell.m
//  DemoProject
//
//  Created by zj on 13-11-3.
//
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize contentTV;
@synthesize userImage;
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize upButton;
@synthesize downButton;
@synthesize responseButton;
@synthesize aComment;
@synthesize isVote;
@synthesize statusId;

- (void)setHeightForCell{
    [contentTV layoutIfNeeded];
    
    CGRect frame = contentTV.frame;
    frame.size = contentTV.contentSize;
    contentTV.frame = frame;
    
    frame = userImage.frame;
    frame.origin.y = contentTV.frame.origin.y + contentTV.frame.size.height + 5;
    userImage.frame = frame;
    
    frame = nameLabel.frame;
    frame.origin.y = userImage.frame.origin.y;
    nameLabel.frame = frame;
    
    frame = timeLabel.frame;
    frame.origin.y = userImage.frame.origin.y;
    timeLabel.frame = frame;
    
    frame = upButton.frame;
    frame.origin.y = nameLabel.frame.origin.y + nameLabel.frame.size.height + 5;
    upButton.frame = frame;
    
    frame = downButton.frame;
    frame.origin.y = upButton.frame.origin.y;
    downButton.frame = frame;
    
    frame = responseButton.frame;
    frame.origin.y = upButton.frame.origin.y;
    responseButton.frame = frame;
}

- (void)setUpCell:(Comment*)comment withData:(NSData*)headImage andStatusId:(NSNumber*)_statusId{
    manager = [[HTTPMessageManager alloc]init];
    self.aComment = comment;
    self.isVote = aComment.isVote;
    self.statusId = _statusId;
    
    self.contentTV.text = comment.content;
    if(headImage && ![headImage isEqual:[NSNull null]]){
        self.userImage.image = [UIImage imageWithData:headImage];
    }else{
        self.userImage.image = [UIImage imageNamed:@"userImage.png"];
    }
    self.nameLabel.text = comment.summitedUser.nickName;
    self.timeLabel.text = [comment timestamp];
    [upButton setTitle:[NSString stringWithFormat:@"顶 (%@)",comment.upsCount] forState:UIControlStateNormal];
    [downButton setTitle:[NSString stringWithFormat:@"踩 (%@)",comment.downsCount] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostUpOrDownCount:) name:PostUpOrDownComment object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didPostResponseToComment:) name:PostResponseToMessage object:nil];
}

- (IBAction)upOrDown:(id)sender {
    if([isVote isEqualToNumber:[NSNumber numberWithInt:0]]){
        if([sender tag] == 10){
            [manager postUpOrDownComment:aComment.commentId andVote:[NSNumber numberWithInt:1]];
            self.isVote = [NSNumber numberWithInt:1];
        }else if([sender tag] == 20){
            [manager postUpOrDownComment:aComment.commentId andVote:[NSNumber numberWithInt:-1]];
            self.isVote = [NSNumber numberWithInt:-1];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您已经互动过了哦！" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }    
}

- (void)didPostUpOrDownCount:(NSNotification*)sender{
    NSDictionary *mainDic = sender.object;
    [upButton setTitle:[NSString stringWithFormat:@"顶 (%@)", [mainDic objectForKey:@"ups"]] forState:UIControlStateNormal];
    [downButton setTitle:[NSString stringWithFormat:@"踩 (%@)", [mainDic objectForKey:@"downs"]] forState:UIControlStateNormal];
    self.isVote = [mainDic objectForKey:@"is_vote"];
}

- (IBAction)responseToAComment:(id)sender {
    [manager postResponseToMessage:statusId andParentId:aComment.commentId andContent:@"Right!!"];
}

- (void)didPostResponseToComment:(NSNotification*)sender{
    NSDictionary *mainDic = sender.object;
    NSLog(@"mainDIc===========%@", mainDic);
//    self.isVote = [mainDic objectForKey:@"is_vote"];
}

- (void)dealloc {
    [contentTV release];
    [userImage release];
    [nameLabel release];
    [timeLabel release];
    [upButton release];
    [downButton release];
    [responseButton release];
    [super dealloc];
}
@end
