//
//  MyCell2.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MyCell2.h"
#import "UserInfo2.h"

@implementation MyCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)] autorelease];
        [self.contentView addSubview:_userImageView];
        
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 30)] autorelease];
        [self.contentView addSubview:_nameLabel];
        
        self.emailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 35, 200, 20)] autorelease];
        [self.contentView addSubview:_emailLabel];
    }
    
    return self;
}

- (void)setDataForCell:(BaseModel *)dataForCell{
    UserInfo2 *userInfo = (UserInfo2 *)dataForCell;
    [super setDataForCell:dataForCell];
    
    [_nameLabel setText:userInfo.name];
    [_emailLabel setText:userInfo.email];
    [_userImageView setImage:userInfo.userImage];
}

+ (CGFloat)cellHeightForModel:(BaseModel *)dataForCell{
    return 60;
}

@end
