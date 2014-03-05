//
//  DataUtils.m
//  UISearchDisplayDemo
//
//  Created by 范林松 on 14-2-28.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "DataUtils.h"

@implementation DataUtils

+(NSDictionary *)parseData{

    //1.获取文本路径
    NSString *textPath = [[NSBundle mainBundle] pathForResource:@"crayons" ofType:@"txt"];
    //2.将文本数据转换为字符串
    NSString *textString = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
    //3.分割字符串
    NSArray *textstringArray = [textString componentsSeparatedByString:@"\n"];
    //4.实例化字典对象
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //5.分割字典KEY-Value
    for (int i= 0; i<textstringArray.count; i++) {
        
        NSArray *value = [textstringArray[i] componentsSeparatedByString:@" #"];
        for (int j=0; j<value.count-1; j++) {
            //将分割后的KEY---Value 以键值对形式存入可变字典即MAp集合中
            [dictionary setObject:value[j+1] forKey:value[j]];
        }
        
    }
    
    
    return  dictionary;
}

@end
