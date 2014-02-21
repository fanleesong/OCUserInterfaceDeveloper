//
//  NetImageDataManager.h
//  DemoProject
//
//  Created by administrator on 13-11-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

#define NETIMAGEDATA_NOTIFICATION @"NetImageDataNotification"
#define NETHEAD_IMAGEDATA_NOTIFICATION @"NetHeadImageDataNotification"
#define IMAGEDATA_URL @"imageDataUrl"
#define IMAGEDATA @"imageData"
#define IMAGEDATA_INDEX @"imageDataIndex"

@interface NetImageDataManager : NSObject<ASIHTTPRequestDelegate, ASIProgressDelegate>{
    NSMutableDictionary *dic;
    NSMutableArray *arr;
}

+ (NetImageDataManager*)getInstance;
- (void)getDataWithUrl:(NSString*)url withIndex:(NSInteger)index;

@end
