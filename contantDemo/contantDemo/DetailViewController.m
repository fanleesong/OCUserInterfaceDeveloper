//
//  DetailViewController.m
//  contantDemo
//
//  Created by 范林松 on 14-2-17.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    BOOL isFlag;//控制编辑状态
}
@end

@implementation DetailViewController

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
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 80, 80)];
    avatarImageView.image = self.contactItem.contactAvatarImage;
    [self.view addSubview:avatarImageView];
    [avatarImageView release],avatarImageView = nil;
    
    UILabel *contaxtName = [[UILabel alloc] initWithFrame:CGRectMake(110, 84, 200, 40)];
    contaxtName.tag = 100;
    contaxtName.font = [UIFont boldSystemFontOfSize:20];
    contaxtName.textAlignment = NSTextAlignmentLeft;
    contaxtName.textColor = [UIColor redColor];
    contaxtName.text = self.contactItem.contactName;
    [self.view addSubview:contaxtName];
    
    UILabel *contaxtPhone = [[UILabel alloc] initWithFrame:CGRectMake(110, 134, 200, 30)];
    contaxtPhone.tag = 200;
    contaxtPhone.font = [UIFont boldSystemFontOfSize:20];
    contaxtPhone.textAlignment = NSTextAlignmentLeft;
    contaxtPhone.textColor = [UIColor redColor];
    contaxtPhone.text = self.contactItem.contactPhoneNumber;
    [self.view addSubview:contaxtPhone];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rigthButtAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem release],rightBarButtonItem = nil;
    
    
}

-(void)rigthButtAction:(UIBarButtonItem *)sender{
    
    if (!isFlag) {
     
//        for (id objects in self.view.subviews) {
//            if ([objects isKindOfClass:[UILabel class]]) {
//                UILabel *onelabel = (UILabel *)objects;
//                onelabel.hidden = YES;
//            }
//        }
//        UIBarButtonItem *shi = (UIBarButtonItem *)sender;
//        shi.title = @"Done";
        sender.title = @"完成";

        
        UILabel *onelabel = (UILabel *)[self.view viewWithTag:100];
        onelabel.hidden = YES;
        UILabel *twolabel = (UILabel *)[self.view viewWithTag:200];
        twolabel.hidden = YES;
        
        
        UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(110, 84, 200, 40)];
        nameField.text = self.contactItem.contactName;
        nameField.tag = 111;
        //让第一个textField成为第一响应值
        [nameField becomeFirstResponder];
        [self.view addSubview:nameField];
        [nameField release],nameField = nil;
        
        UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(110, 134, 200, 30)];
        phone.text = self.contactItem.contactPhoneNumber;
        phone.tag = 222;
        phone.keyboardType = UIKeyboardTypeNumberPad;
        //让第一个textField成为第一响应值
        [self.view addSubview:phone];
        [phone release],phone = nil;

        isFlag = YES;
        
    }else{
//        UIBarButtonItem *shi = (UIBarButtonItem *)sender;
//        shi.title = @"Edit";
        sender.title = @"编辑";
        
        UILabel *NameLable = (UILabel *)[self.view viewWithTag:100];
        UITextField *nameText = (UITextField *)[self.view viewWithTag:111];
        NameLable.text= nameText.text;
        self.contactItem.contactName = nameText.text;
        [nameText removeFromSuperview];
        NameLable.hidden = NO;
        UILabel *PhoneLabel = (UILabel *)[self.view viewWithTag:200];
        UITextField *phoneTxt = (UITextField *)[self.view viewWithTag:222];
        PhoneLabel.text = phoneTxt.text;
        self.contactItem.contactPhoneNumber = phoneTxt.text;
        [phoneTxt removeFromSuperview];
        PhoneLabel.hidden = NO;
        
        isFlag = NO;
        
       //开始代理传值
        if (self.delegate &&[self.delegate respondsToSelector:@selector(didEditContactInfo:atIndexPath:)]) {
            [self.delegate didEditContactInfo:self.contactItem atIndexPath:self.indexPath];
        }
        
        
    }
}


-(void)dealloc{
    [_contactItem release];
    [_indexPath release];
    [super dealloc];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
