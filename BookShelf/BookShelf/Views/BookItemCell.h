//
//  BookItemCell.h
//  BookShelf
//
//  Created by 范林松 on 14-2-26.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookItemCell : UITableViewCell

@property (nonatomic,retain) UIImageView *bookAvatarImageView;
@property (nonatomic,retain) UILabel *bookNameLabel;
@property (nonatomic,retain) UILabel *bookPriceLabel;
@property (nonatomic,retain) UILabel *bookCatagoryLabel;

@end
