//
//  MyCommentCell.h
//  ChouTi
//
//  Created by administrator on 13-11-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyComment.h"

@interface MyCommentCell : UITableViewCell {
    UITextView *content;
    UILabel *timeLabel;
}

@property (retain, nonatomic) IBOutlet UITextView *content;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setUpMyCommentCell:(MyComment*)comment;

@end
