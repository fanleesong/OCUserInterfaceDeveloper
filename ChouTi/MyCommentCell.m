//
//  MyCommentCell.m
//  ChouTi
//
//  Created by administrator on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MyCommentCell.h"

@implementation MyCommentCell
@synthesize content;
@synthesize timeLabel;

- (void)setHeight{
    [content layoutIfNeeded];
    
    CGRect frame = content.frame;
    frame.size = content.contentSize;
    content.frame = frame;
    
    frame = timeLabel.frame;
    frame.origin.y = content.frame.origin.y + content.frame.size.height + 5;
    timeLabel.frame = frame;
}

- (void)setUpMyCommentCell:(MyComment*)comment{
    content.text = comment.content;
    timeLabel.text = [comment timestamp];
    [self setHeight];
}

- (void)dealloc {
    [content release];
    [timeLabel release];
    [super dealloc];
}

@end
