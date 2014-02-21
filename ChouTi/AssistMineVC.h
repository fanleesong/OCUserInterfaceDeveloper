//
//  AssistMineVC.h
//  ChouTi
//
//  Created by administrator on 13-11-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPMessageManager.h"

#define TextViewPadding            16.0
#define LineBreakMode              UILineBreakModeWordWrap
#define IMAGE_HEIGHT 80.0f

typedef enum {
    save,
    publish,
    recommend,
    comment
} InfoType;

@interface AssistMineVC : UITableViewController {
    InfoType infoType;
    HTTPMessageManager *manager;
    NSMutableDictionary *imageDictionary;
    NSArray *arr;
}

@property (assign, nonatomic)InfoType infoType;
@property (retain, nonatomic)NSArray *arr;

- (void)didGetMyList:(NSNotification*)sender;
- (void)pushComments:(NSInteger)index;

@end
