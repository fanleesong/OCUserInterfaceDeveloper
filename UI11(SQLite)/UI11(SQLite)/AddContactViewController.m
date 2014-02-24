//
//  AddContactViewController.m
//  UI11(SQLite)
//
//  Created by 范林松 on 14-2-24.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "AddContactViewController.h"
#import "ContactDao.h"
#import "ContactInfo.h"

@interface AddContactViewController ()

@property (nonatomic ,retain) UITextField *nameField;
@property (nonatomic ,retain) UITextField *passwordField;
@property (nonatomic ,retain) UISwitch *sexSwitch;

@end

@implementation AddContactViewController

-(void)dealloc{
    
    [_nameField release],_nameField = nil;
    [_passwordField release],_passwordField = nil;
    [_sexSwitch release],_sexSwitch = nil;
    [super dealloc];

}

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
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.nameField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 80, 280, 40)] autorelease];
    self.nameField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nameField];
    
    self.passwordField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 130, 280, 40)] autorelease];
    self.passwordField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.passwordField];
    
    
    self.sexSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(20, 180, 80, 40)] autorelease];
    self.sexSwitch.on = YES;
    [self.view addSubview:self.sexSwitch];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem release],rightBarButtonItem = nil;
    
}
#pragma mark -添加数据方法-
-(void)addAction:(UIBarButtonItem *)sender{
    
    //向数据库中插入数据
    NSString *name = self.nameField.text;
    NSString *passwod = self.passwordField.text;
    NSString *gender = self.sexSwitch.on ?@"男":@"女";
    
    ContactInfo *contactInfos = [[ContactInfo alloc] initWithUsername:name password:passwod contactNum:gender];
    
    if ([ContactDao insertContactInfo:contactInfos]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加新联系人" message:@"插入数据成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release],alert = nil;
    }
    [contactInfos release],contactInfos = nil;
    
    
    



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
