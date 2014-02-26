//
//  BookItemCell.m
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "BookItemCell.h"

@implementation BookItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        //调用设置相关属性方法
        [self _initSomeProperty];
        
    }
    return self;
}
#pragma  mark-实例化属性-
-(void)_initSomeProperty{
    
    
    //实例化
    self.bookAvatarImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 42, 56)] autorelease];
    [self addSubview:self.bookAvatarImageView];
    //类别
    self.bookCatagoryLabel = [[[UILabel alloc] initWithFrame:CGRectMake(152,40,120,20)] autorelease];
    self.bookCatagoryLabel.font = [UIFont systemFontOfSize:10];
    self.bookCatagoryLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bookCatagoryLabel];
    //书名
    self.bookNameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(72, 10,200, 25)] autorelease];
    self.bookNameLabel.font = [UIFont boldSystemFontOfSize:15];
    self.bookNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bookNameLabel];
    //价格
    self.bookPriceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(72,40,60,20)] autorelease];
    self.bookPriceLabel.font = [UIFont systemFontOfSize:10];
    self.bookPriceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.bookPriceLabel];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    
    [_bookAvatarImageView release];
    [_bookCatagoryLabel release];
    [_bookNameLabel release];
    [_bookPriceLabel release];
    [super dealloc];

}

@end
