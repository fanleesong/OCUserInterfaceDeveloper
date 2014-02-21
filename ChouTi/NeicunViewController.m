//
//  NeicunViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NeicunViewController.h"
#import "HistoryViewController.h"

@implementation NeicunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self fileSizeAtPath:];
    unsigned long long count = [self fileSizeAtPath:@""]; 
    neicunCountLabel.text = [NSString stringWithFormat:@"%@", [self fileSizeAtPath:@""]];
    if (count > 1) {
        descripLabel.text = @"抽屉太乱了，赶紧清理下吧！";
    }
    else{
        descripLabel.text = @"抽屉很整洁，不需要清理了";
    }
}

- (void)viewDidUnload
{
    [neicunCountLabel release];
    neicunCountLabel = nil;
    [descripLabel release];
    descripLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [neicunCountLabel release];
    [descripLabel release];
    [super dealloc];
}

- (unsigned long long)fileSizeAtPath:(NSString*) filePath  

{  
    NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];  
    return [[attr objectForKey:NSFileSize] unsignedLongLongValue];  
    
} 

- (IBAction)clearButton:(id)sender {
    NSString * file = NSHomeDirectory(); //获取沙盒根目录
    NSLog(@"homefile = %@",file);
    //NSString *localPath = [NSHomeDirectory()stringByAppendingPathComponent:@"/Documents"] ; 
    NSFileManager *fileManager = [NSFileManager defaultManager]; 
    NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:file error:nil]; 
    NSLog(@"array =  ---------------%@",fileArray);
    for (NSString *str in fileArray) { 
        [fileManager removeItemAtPath:file error:nil]; 
    } 

}

- (IBAction)historyButton:(id)sender {
    HistoryViewController * history = [[HistoryViewController alloc]init];
    [self.navigationController pushViewController:history animated:YES];
    [history release];
}

@end
