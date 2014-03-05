//
//  NSString+Reverse.m
//  UI15-(urlRequest)
//
//  Created by 范林松 on 14-3-4.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)

-(id)reverseString{
    
    NSUInteger lengths = [self length];//可变int
    //    self 表示字符串本身
    //    根据可变长度，创建对应字符串
    NSMutableString *reString = [NSMutableString stringWithCapacity:lengths];
    while (lengths>0) {
        unichar c = [self characterAtIndex:--lengths];
        //从后取一个字符串 Unicode
        NSLog(@"c is %C",c);
        NSString *s = [NSString stringWithFormat:@"%c",c];
        [reString appendString:s];
    }
    return reString;
    
}
@end
