//
//  JsonViewController.m
//  homeworkJSOM&XML
//
//  Created by 范林松 on 14-3-3.
//  Copyright (c) 2014年 范林松. All rights reserved.
//

#import "JsonViewController.h"
@interface JsonViewController ()

@end

@implementation JsonViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _grapDataByGet];
    NSLog(@"%d",self.dataDictionary.count);
    self.locationArray = [NSMutableArray array];
    //获取最外层数组字典
    self.locationArray = [self.dataDictionary objectForKey:@"results"];
    for (int i= 0; i<self.locationArray.count; i++) {
        
    }
    

}


#pragma mark--获取请求数据--
-(void)_grapDataByGet{
    
    //获取网络数据地址字符串
    NSString *urlString = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=37.785834,-122.406417&sensor=true";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *datas = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.dataDictionary= [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
    
//    NSLog(@"%@",self.dataDictionary);
//    NSLog(@"%@",[dics objectForKey:@"status"]);
    
//    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    return cell;
}

-(void)dealloc{
    [_showData release];
    [_dataDictionary release];
    [_locationArray release];
    [super dealloc];
}

@end
