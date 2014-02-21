//
//  ComplaintViewController.m
//  HorseKeeping
//
//  Created by OldHorse on 13-4-2.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "ComplaintViewController.h"

@interface ComplaintViewController ()

@end

@implementation ComplaintViewController

@synthesize StaffID;
@synthesize ComplaintText;


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
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
}

-(IBAction)CLearKeyBoard:(id)sender{
    if ([self.StaffID isFirstResponder]) {
        [self.StaffID resignFirstResponder];
    }if ([self.ComplaintText canResignFirstResponder]) {
        [self.ComplaintText resignFirstResponder];
    }
}

-(IBAction)Submit:(id)sender{
    [self postData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            
            break;
        }case 1:{
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}


-(void)postData
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *imei = [device uniqueIdentifier];
    
    if (self.StaffID.text == nil || self.StaffID.text == NULL || [self.StaffID.text isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"工号不能为空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }if (self.ComplaintText.text == nil || [self.ComplaintText.text isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"不需要说些什么吗?" message:nil delegate:self cancelButtonTitle:@"不是" otherButtonTitles:@"是的", nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //        applyId	       int	手机应用id
        //        token	String	手机串号
        //        siteId	int	商家ID
        //        name	String	名称（工号）
        //        content	String	原因
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        
        
        [params setObject:[NSNumber numberWithInt:APP_ID] forKey:@"applyId"];
        [params setObject:imei forKey:@"token"];
        [params setObject:[NSNumber numberWithInt:STORE_ID] forKey:@"siteId"];
        [params setObject:self.StaffID.text forKey:@"name"];
        [params setObject:self.ComplaintText.text forKey:@"content"];
        
        
        NSString *url = COMPLAIN_SAVE;
        id result = [KRHttpUtil getResultDataByPost:url param:params];
        
        if ([[result objectForKey:@"success"] boolValue])
        {
            //refresh view
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提交成功" message:@"成功提交您的投诉信息，请等待回复" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                alertView.tag = 123;
                [alertView show];
            });
            
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提交失败" message:[result objectForKey:@"reason"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                [alertView show];
                
            });
            
        }
        
        
        
        
        
    });
    
    
}


-(IBAction)BackView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
