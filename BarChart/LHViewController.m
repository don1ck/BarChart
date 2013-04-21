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
    NSDictionary * data = @{@1 : @1.5, @3 : @3.9, @4 : @4.9, @5 : @5.9, @6 : @6.9,@7 : @7.5, @8 : @8.4, @9 : @3.9, @10 : @4.9, @11 : @5.9, @12 : @6.9};
    
    LHBarChart * chartView = [[LHBarChart alloc] initWithChartData:data andChartBar:[[[LHSquareBar alloc] init] autorelease]];
    LHScrollableContainer * container = [[LHScrollableContainer alloc] initWithChartView:chartView andRect:self.view.bounds];


    container.backgroundColor =[UIColor whiteColor];
    container.chartView.backgroundColor = [UIColor whiteColor];
    [(LHBarChart*)container.chartView setIsAccessibilityElement:YES];
    [self.view addSubview:container];
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
