//
//  BJNewsItem.h
//  BeiJingNews
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJNewsItem : NSObject

@property (nonatomic,retain) NSString *newsTitle;
@property (nonatomic,retain) NSString *newsSummary;
@property (nonatomic,retain) NSString *newsPublishDate;
@property (nonatomic,retain) NSString *newsPicURL;
@property (nonatomic,retain) NSString *newsURL;

//-(id)initNewsTitle:(NSString *)newsTitle
//        newSummary:(NSString *)newsSummary
//   newsPublishDate:(NSString *)newsPublishDate
//         newsPicURL:(NSString *)newsPublishDate
//           newsURL:(NSString *)newsURL;

-(id)initWithDictionatry:(NSDictionary *)dictionary;


@end
