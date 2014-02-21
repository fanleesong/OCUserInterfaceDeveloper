//
//  ImageLoader.m
//  iphone_golf
//
//  Created by apple on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader
//把 NSString  转换成 UIImage 
+ (UIImage *)loadImage:(NSString *)imageNameString
{
    if (imageNameString == NULL) {
        return nil;
    }
    imageNameString = [imageNameString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
    // load from bundle
    NSString *imagePathString = [NSString stringWithFormat:@"%@/taihua.bundle/images/%@", [[NSBundle mainBundle] resourcePath], imageNameString];
    NSLog(@"%@" , imageNameString);
    NSLog(@"%@" , [[NSBundle mainBundle] resourcePath]);
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePathString]) {
        return [UIImage imageWithContentsOfFile:imagePathString];
    }
    // load from cache
    imagePathString = [NSString stringWithFormat:@"%@/Documents/images/%@", NSHomeDirectory(), imageNameString];
    NSLog(@"%@" , imagePathString);
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePathString]) {
        // remove 0 size file
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:imagePathString error:nil];
        unsigned long long fileSize = [attributes fileSize];
        if (fileSize == 0) {
            [[NSFileManager defaultManager] removeItemAtPath:imagePathString error:nil];
        }
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePathString]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePathString withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:imagePathString error:nil];
        NSString *imageURLString = [NSString stringWithFormat:@"http://shop.88bx.com/staticmedia/images/%@", [imageNameString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [[NSFileManager defaultManager] createFileAtPath:imagePathString contents:imageData attributes:nil];
    }
    return [UIImage imageWithContentsOfFile:imagePathString];
}

@end
