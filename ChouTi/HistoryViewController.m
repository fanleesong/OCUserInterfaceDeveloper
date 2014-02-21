//
//  HistoryViewController.m
//  ChouTi
//
//  Created by administrator on 13-11-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"
//#import "PNChart.h"

@implementation HistoryViewController
@synthesize chartScrollView;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //Add LineChart

//	UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
//	lineChartLabel.text = @"Line Chart";
//	lineChartLabel.textColor = PNFreshGreen;
//	lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
//	lineChartLabel.textAlignment = UITextAlignmentCenter;
//	
//	PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 75.0, SCREEN_WIDTH, 200.0)];
//	lineChart.backgroundColor = [UIColor clearColor];
//    [lineChart setXLabels:[NSArray arrayWithObjects:@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5", nil]];
//    [lineChart setYValues:[NSArray arrayWithObjects:@"1",@"10",@"2",@"6",@"3", nil]];
//	//[lineChart setYValues:@[@"1",@"10",@"2",@"6",@"3"]];
//	[lineChart strokeChart];
//	[self.chartScrollView addSubview:lineChartLabel];
//	[self.chartScrollView addSubview:lineChart];
//	
//	//Add BarChart
//	
//	UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 30)];
//	barChartLabel.text = @"Bar Chart";
//	barChartLabel.textColor = PNFreshGreen;
//	barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
//	barChartLabel.textAlignment = UITextAlignmentCenter;
//	
//	PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 335.0, SCREEN_WIDTH, 200.0)];
//	barChart.backgroundColor = [UIColor clearColor];
//	barChart.type = PNBarType;
//    [barChart setXLabels:[NSArray arrayWithObjects:@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5", nil]];
//    [barChart setYValues:[NSArray arrayWithObjects:@"1",@"10",@"2",@"6",@"3", nil]];
//	[barChart strokeChart];
//	[self.chartScrollView addSubview:barChartLabel];
//	[self.chartScrollView addSubview:barChart];
//
//    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
