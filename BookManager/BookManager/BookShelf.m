//
//  BookShelf.m
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookShelf.h"

@implementation BookShelf


-(void)dealloc{

    [_bookCoverImage release],_bookCoverImage = nil;
    [_bookNameLabel release ],_bookNameLabel = nil;
    [_typeLabel release],_typeLabel = nil;
    [_priceLabel release],_priceLabel = nil;
    [_bookInfo release],_bookInfo = nil;
    [super dealloc];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //64
        //图片
        self.bookCoverImage = [[[UIImageView alloc] initWithFrame: CGRectMake(20,10,40,50)] autorelease];
        [self addSubview:self.bookCoverImage];
        
        //图书名
        self.bookNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70,10,220,25)] autorelease];
        self.bookNameLabel.textAlignment = NSTextAlignmentCenter;
        self.bookNameLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.bookNameLabel];
        
        //价格
        self.priceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 45,50, 25)] autorelease];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.priceLabel];
        
        
        //类别
        self.typeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(140, 45,150, 25)] autorelease];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.typeLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
