//
//  NetImageDataManager.m
//  DemoProject
//
//  Created by administrator on 13-11-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NetImageDataManager.h"

#define MAXIMAGECOUNT 20

static NetImageDataManager *instance = nil;

@implementation NetImageDataManager

-(id)init{
    if(self = [super init]){
        dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        arr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

+ (NetImageDataManager*)getInstance{
    @synchronized(self){
        if(instance == nil){
            instance = [[NetImageDataManager alloc]init];
        }
    }
    return instance;
}

- (void)sendNotificationWithUrl:(NSString*)url andData:(NSData*)data andIndex:(NSNumber*)index{
    NSDictionary *postDic = [[NSDictionary alloc]initWithObjectsAndKeys:url, IMAGEDATA_URL, data, IMAGEDATA, index, IMAGEDATA_INDEX, nil];
    NSInteger i = [index intValue];
    if(i < 0){
        [[NSNotificationCenter defaultCenter]postNotificationName:NETHEAD_IMAGEDATA_NOTIFICATION object:postDic];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:NETIMAGEDATA_NOTIFICATION object:postDic];
    }
    [postDic release];
}

- (void)getDataWithUrl:(NSString*)url withIndex:(NSInteger)index{
    if(url == nil || url.length == 0){
        return;
    }
    int i;
    @synchronized(self){
        for(i = 0; i < [arr count]; i++){
            NSString *str = [arr objectAtIndex:i];
            if([url isEqualToString:str]){
                break;
            }
        }
        if(i < [arr count]){
            //match
            NSData *data = [dic objectForKey:[arr objectAtIndex:i]];
            NSNumber *indexNumber = [NSNumber numberWithInt:index];
            [self sendNotificationWithUrl:url andData:data andIndex:indexNumber];
        }else{
            //unmatch
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            request.delegate = self;
            request.downloadProgressDelegate = self;     //?????
            request.uploadProgressDelegate = self;     //?????
            NSNumber *indexNumber = [NSNumber numberWithInt:index];
            [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:url, @"url", indexNumber, @"index", nil]];
            [request startAsynchronous];
        }
    }
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = [request responseData];
    NSString *url = [request.userInfo objectForKey:@"url"];
    NSNumber *index = [request.userInfo objectForKey:@"index"];
    [self sendNotificationWithUrl:url andData:data andIndex:index];
    @synchronized(self){
        [arr insertObject:url atIndex:0];
        [dic setValue:data forKey:url];
        if([arr count] > MAXIMAGECOUNT){
            NSString *aObject = [[arr lastObject]retain];
            [arr removeLastObject];
            int i;
            for(i = 0; i < [arr count]; i++){
                if([aObject isEqualToString:[arr objectAtIndex:i]]){
                    break;
                }
            }
            if(i == [arr count]){
                [dic removeObjectForKey:aObject];
            }
            [aObject release];
        }
    }
}

@end
