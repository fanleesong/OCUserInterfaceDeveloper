//
//  HomePageVC.h
//  DemoProject
//
//  Created by administrator on 13-11-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPMessageManager.h"
#import "EGORefreshTableHeaderView.h"

@interface HomePageVC : UITableViewController <EGORefreshTableHeaderDelegate>{
    HTTPMessageManager *manager;
    NSNotificationCenter *notificationCenter;
    NSArray *statusArr;
    SubjectType subjectType;
    NSMutableDictionary *imageDictionary;
    
    IBOutlet UIView *LoadView;
    EGORefreshTableHeaderView* _refreshHeaderView;
    BOOL _reloading;
    UIView *upView;
}

@property (retain, nonatomic) IBOutlet UIView *upView;
@property (retain, nonatomic)NSArray *statusArr;
@property (assign, nonatomic)SubjectType subjectType;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

- (void)pushCommentsView:(NSInteger)index;

- (void)didGetHomePageInfo:(NSNotification*)sender;
- (void)getImages;
- (void)didGetImages:(NSNotification*)sender;
- (IBAction)toTop:(id)sender;

@end
