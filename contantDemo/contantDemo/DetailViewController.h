//
//  DetailViewController.h
//  contantDemo
//
//  Created by 范林松 on 14-2-17.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactItem.h"
@protocol DetailViewDelegate<NSObject>

-(void)didEditContactInfo:(ContactItem *)item
              atIndexPath:(NSIndexPath *)indexPath;

@end



@interface DetailViewController : UIViewController

//属性声明 声明为ContacrtItem类型，将上一页面传递到详细页面并显示
@property(nonatomic,retain)ContactItem *contactItem;
@property(nonatomic,retain)NSIndexPath *indexPath;
@property(nonatomic,assign)id<DetailViewDelegate> delegate;

@end
