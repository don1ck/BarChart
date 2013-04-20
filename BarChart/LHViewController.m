//
//  LHViewController.m
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHViewController.h"
#import <LHChart/LHChart.h>



@interface LHViewController ()

@end

@implementation LHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary * data = @{@1 : @1.5, @2 : @2.9, @3 : @3.9, @4 : @4.9, @5 : @5.9, @6 : @6.9};
    
    LHBarChart * someView = [[LHBarChart alloc] initWithChartData:data andRect:CGRectMake(10, 10, 300, 200)];
    someView.backgroundColor =[UIColor whiteColor];
    someView.chartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:someView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
