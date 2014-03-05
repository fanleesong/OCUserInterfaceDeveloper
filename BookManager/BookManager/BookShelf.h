//
//  BookShelf.h
//  BookManager
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Books.h"
@interface BookShelf : UITableViewCell

@property(nonatomic,retain)UILabel *bookNameLabel;
@property(nonatomic,retain)UILabel *priceLabel;
@property(nonatomic,retain)UILabel *typeLabel;
@property(nonatomic,retain)UIImageView *bookCoverImage;
@property(nonatomic,retain) Books *bookInfo;

@end
