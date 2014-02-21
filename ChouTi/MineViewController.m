//
//  MineViewController.m
//  ChouTi
//
//  Created by hh on 13-11-6.
//
//

#import "MineViewController.h"
#import "AssistMineVC.h"

@implementation MineViewController
@synthesize dic;

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.jpg"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bacg.jpg"]];
    self.navigationItem.title = @"我的";
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [saveLabel release];
    saveLabel = nil;
    [sendLabel release];
    sendLabel = nil;
    [recommendLabel release];
    recommendLabel = nil;
    [commentLabel release];
    commentLabel = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    saveLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"saveCount"]];
    sendLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"submittedCount"]];
    recommendLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"likedCount"]];
    commentLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"commentsCount"]];
}

- (void)dealloc {
    [saveLabel release];
    [sendLabel release];
    [recommendLabel release];
    [commentLabel release];
    [super dealloc];
}

#pragma mark - buttonMethods

- (IBAction)enterDetailVC:(id)sender{
    AssistMineVC *detainView = [[AssistMineVC alloc]initWithNibName:@"AssistMineVC" bundle:nil];
    if([sender tag] == 1){
        detainView.infoType = save;
    }else if([sender tag] == 2){
        detainView.infoType = publish;
    }else if([sender tag] == 3){
        detainView.infoType = recommend;
    }else if([sender tag] == 4){
        detainView.infoType = comment;
    }
    [self.navigationController pushViewController:detainView animated:YES];
    [detainView release];
}

- (IBAction)unLogin:(id)sender {
    
}

@end
