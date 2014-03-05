//
//  Students.m
//  UI14-XML&SAX
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "Students.h"

@implementation Students


-(void)dealloc{
    self.name = nil;
    self.telephoneNumber = nil;
    self.gender = nil;
    [super dealloc];
}
-(NSString *)description{
    
    return [NSString stringWithFormat:@"姓名为：%@,性别为：%@，电话为：%@",self.name,self.gender,self.telephoneNumber];
    
}
@end
