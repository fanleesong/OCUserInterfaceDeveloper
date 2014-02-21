//
//  AppointmentViewController.m
//  Housekeeping
//
//  Created by user on 13-3-29.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "AppointmentViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    callNum=[[NSString alloc]init];
    [self pressCall];
    // Do any additional setup after loading the view from its nib.
}
-(void)pressCall
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *imei = [device uniqueIdentifier];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // request data from the server
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        [params setObject:[NSNumber numberWithInt:STORE_ID] forKey:@"id"];
        [params setObject:[NSNumber numberWithInt:APP_ID] forKey:@"applyId"];
        [params setObject:imei forKey:@"token"];
        
        
        NSString *url = CALL_US;
        id result = [KRHttpUtil getResultDataByPost:url param:params];
        if ([result objectForKey:@"success"])
        {
            id records = [result objectForKey:@"phone"];
            
            if (records == [NSNull null])
            {
                NSLog(@"%@ --------records == NSNull",url);
                
            }
            else
            {
                callNum = [records copy];
                NSLog(@"-------------------------------------callNum%@" , records);
                
            }
        }
        
        else
        {
            NSLog(@"%@",[NSString stringWithFormat:@"Class:%@:  url:%@ reason:%@",[self class],url,[result objectForKey:@"reason"]]);
        }
        
        
        
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (IBAction)appoint:(id)sender {
    NSString *numUrl = [[NSString alloc] initWithFormat:@"tel://%@",callNum];
    NSLog(@"numUrl=%@",numUrl);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numUrl]];
}
@end
