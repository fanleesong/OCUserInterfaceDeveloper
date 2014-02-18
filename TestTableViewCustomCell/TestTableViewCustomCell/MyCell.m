//
//  MyCell.m
//  TestTableViewCustomCell
//
//  Created by 波波 on 14-1-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MyCell.h"
#import "UserInfo.h"
#import "BaseCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 30)] autorelease];
        [self.contentView addSubview:_nameLabel];
        
        self.phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 200, 30)] autorelease];
        [self.contentView addSubview:_phoneLabel];
        
        CGRect rect = self.contentView.bounds;
        rect.origin.x = rect.size.width - 10 - 60;
        rect.origin.y = 10;
        rect.size.width = 60;
        rect.size.height = 60;
        self.userImageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
        [self.contentView addSubview:_userImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataForCell:(BaseModel *)dataForCell{
    
    if (self.dataForCell != dataForCell) {
        //调用父类继承的setter 方法，防止递归
        [super setDataForCell:dataForCell];
        
        UserInfo *userInfo = (UserInfo *)dataForCell;
        [self.nameLabel setText:userInfo.name];
        [self.phoneLabel setText:userInfo.phoneNumber];
        [self.userImageView setImage:userInfo.userImage];
    }
}

+ (CGFloat)cellHeightForModel:(BaseModel *)dataForCell{
    return 80;
}


@end
