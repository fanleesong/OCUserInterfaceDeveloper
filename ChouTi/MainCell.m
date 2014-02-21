//
//  MainCell.m
//  DemoProject
//
//  Created by zj on 13-11-3.
//
//

#import "MainCell.h"
#import "UIImageView+Curled.h"
#import "QuartzCore/QuartzCore.h"

#define IMAGE_HEIGHT 80.0f
#define IMAGE_WIDTH 75.0f
static NSString * fontType = @"YES";

@implementation MainCell
@synthesize upImage;
@synthesize upButton;
@synthesize commentImage;
@synthesize commentButton;
@synthesize user;
@synthesize aStatus;
@synthesize index;
@synthesize content;
@synthesize contentImageView;
@synthesize userName;
@synthesize submittedTime;
@synthesize delegate;

- (void)setHeightOfCell{
    [content layoutIfNeeded];
    
    CGRect frame = content.frame;
    frame.size = content.contentSize;
    content.frame = frame;
    
    frame = contentImageView.frame;
    frame.origin.x = content.frame.origin.x + content.frame.size.width;
    frame.origin.y = content.frame.origin.y + 13;
    frame.size.height = IMAGE_HEIGHT;
    if(frame.size.width > IMAGE_WIDTH){
        frame.size.width = IMAGE_WIDTH;
    }
    contentImageView.frame = frame;
    
    
    if((content.frame.origin.y + content.frame.size.height) < (content.frame.origin.y + IMAGE_HEIGHT)){
        
        frame = userName.frame;
        frame.origin.y = contentImageView.frame.origin.y + IMAGE_HEIGHT + 5;
        userName.frame = frame;
        
        
    }else{
        frame = userName.frame;
        frame.origin.y = content.frame.origin.y + content.frame.size.height + 5;
        userName.frame = frame;
    }
    
    frame = submittedTime.frame;
    frame.origin.y = userName.frame.origin.y;
    submittedTime.frame = frame;
    
    frame = upImage.frame;
    frame.origin.y = userName.frame.origin.y + userName.frame.size.height + 5;
    upImage.frame = frame;
    
    frame = upButton.frame;
    frame.origin.y = upImage.frame.origin.y;
    upButton.frame = frame;
    
    frame = commentImage.frame;
    frame.origin.y = upImage.frame.origin.y;
    commentImage.frame = frame;
    
    frame = commentButton.frame;
    frame.origin.y = upImage.frame.origin.y;
    commentButton.frame = frame;
}

- (void)setUpCell:(Status*)status withSubjectType:(SubjectType)subjectType andImage:(NSData*)image{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeType:) name:CHANGEFONTTYPE object:nil];
    manager = [[HTTPMessageManager alloc]init];
    isUp = status.hasUped;
    self.aStatus = status;

    if(subjectType == Hot){
        NSString *type;
        if(status.subjectType != Rumour){
            if(status.subjectType == News){
                type = @"42区";
            }else if(status.subjectType == Scoff){
                type = @"段子";
            }else if(status.subjectType == Tec){
                type = @"挨踢1024";
            }else if(status.subjectType == Pic){
                type = @"图片";
            }else if(status.subjectType == Ask){
                type = @"你问我答";
            }
            self.content.text = [NSString stringWithFormat:@"%@ (%@)",status.title, type];
          
        }else{
            self.content.text = [NSString stringWithFormat:@"【谣言】  %@", status.title];
        }
        self.submittedTime.text = [NSString stringWithFormat:@"%@入热榜", [status hotTimeStamp]];
       
    }else{
        self.content.text = status.title;
        self.submittedTime.text = [NSString stringWithFormat:@"%@发布",[status timestamp]];
    }
    
    if(image && ![image isEqual:[NSNull null]]){
        [contentImageView setImage:[UIImage imageWithData:image] borderWidth:5.0 shadowDepth:10.0 controlPointXOffset:30.0 controlPointYOffset:70.0];
    }else{
        self.contentImageView.image = [UIImage imageNamed:@"loadingImage_50x118.png"];
    }
    
    self.userName.text = [NSString stringWithFormat:@"发布者：%@", status.summitedUser.nickName];
    
    [upButton setTitle:[NSString stringWithFormat:@"%@",status.upsCount] forState:UIControlStateNormal];
    
    [commentButton setTitle:[NSString stringWithFormat:@"%@",status.commentsCount] forState:UIControlStateNormal];
    
    [self setHeightOfCell];
}

- (IBAction)comment:(id)sender {
    [delegate pushCommentsView:index];
}

- (IBAction)isUp:(id)sender {
    if(!isUp){
        [self up];
        isUp = YES;
    }else{
        [self cancelUp];
        isUp = NO;
    }
}

- (void)up {
    NSLog(@"up==========");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetUpMessage:) name:PostUpMessage object:nil];
    [manager postUpMessage:aStatus.statusId];
}

- (void)didGetUpMessage:(NSNotification*)sender{
    NSNumber *ups = sender.object;
    [upButton setTitle:[NSString stringWithFormat:@"%@",ups] forState:UIControlStateNormal];
}

- (void)cancelUp{
    NSLog(@"cancelup=========");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didGetCancelUpMessag:) name:PostCancelUpMessage object:nil];
    [manager postCancelUpMessage:aStatus.statusId];
}

- (void)didGetCancelUpMessag:(NSNotification*)sender{
    NSNumber *ups = sender.object;
    [upButton setTitle:[NSString stringWithFormat:@"%@",ups] forState:UIControlStateNormal];
}

- (void)dealloc {
    [content release];
    [contentImageView release];
    [userName release];
    [submittedTime release];
    [upButton release];
    [commentButton release];
    [upImage release];
    [commentImage release];
    [manager release];
    [super dealloc];
}


-(void)changeType:(NSNotification *)sender{
    fontType = sender.object;
    if ([fontType isEqualToString:@"YES"]) {
        content.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:15];
        submittedTime.font = [UIFont  fontWithName:@"DFPShaoNvW5-GB" size:15];
    }
    else{
        content.font = [UIFont  systemFontOfSize:15];
        submittedTime.font = [UIFont  systemFontOfSize:15];
    }
}

@end
