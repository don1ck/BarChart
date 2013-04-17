//
//  LHViewController.m
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHViewController.h"
#import "LHBarChart.h"

@interface LHViewController ()

@end

@implementation LHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary * data = @{@1 : @15.5, @2 : @20.9, @3 : @25.9, @4 : @30.9, @5 : @35.9, @6 : @40.9};
    
    UIView * someView = [[LHBarChart alloc] initWithChartData:data andRect:CGRectMake(10, 10, 300, 200)];
    someView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:someView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
