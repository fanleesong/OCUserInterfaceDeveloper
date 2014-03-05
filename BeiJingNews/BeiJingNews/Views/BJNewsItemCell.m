//
//  BJNewsItemCell.m
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BJNewsItemCell.h"

@implementation BJNewsItemCell

-(void)dealloc{
    
    [_newAcatarImageView release];
    [_newPublishDataLabel release];
    [_newSummaryLabel release];
    [_newTitleLabel release];
    [super dealloc];
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //10 46 96 61
        self.newAcatarImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(10,46, 96,61)] autorelease];
        [self addSubview:self.newAcatarImageView];
        
        //10 20 274 21
        self.newTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 274, 21)] autorelease];
        self.newTitleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [self addSubview:self.newTitleLabel];
        //114 40 196 53
        self.newSummaryLabel = [[[UILabel alloc] initWithFrame:CGRectMake(114, 40, 196, 53)] autorelease];
        self.newSummaryLabel.font = [UIFont systemFontOfSize:13.0f];
        self.newSummaryLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.newSummaryLabel];
        //220 102 96 21
        self.newPublishDataLabel = [[[UILabel alloc] initWithFrame:CGRectMake(220, 102, 96, 21)] autorelease];
        self.newPublishDataLabel.font = [UIFont systemFontOfSize:10.0f];
        self.newPublishDataLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.newPublishDataLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
