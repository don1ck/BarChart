//
//  LHViewController.m
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHViewController.h"




@interface LHViewController ()
{
	LHScrollableContainer * container;
	
    LHBarChart * chartView;
}

@end

@implementation LHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary * data = @{@1 : @1.5, @3 : @3.9, @4 : @4.9, @5 : @5.9, @6 : @6.9,@7 : @7.5, @8 : @8.4, @9 : @3.9, @10 : @4.9, @11 : @5.9, @12 : @6.9, @13 : @20.5, @14 : @0.9, @15 : @40.9, @16 : @10.9, @17 : @6.9,@18 : @7.5, @19 : @8.4, @20 : @3.9, @21 : @4.9, @22 : @5.9, @23 : @6.9};
    
    chartView = [[LHBarChart alloc] initWithChartData:data andChartBar:[[[LHSquareBar alloc] init] autorelease]];

	container = [[LHScrollableContainer alloc] initWithChartView:chartView andRect:CGRectMake(0, 0, 480, 200)];


    container.backgroundColor =[UIColor whiteColor];
    container.chartView.backgroundColor = [UIColor whiteColor];
    [(LHBarChart*)container.chartView setIsVerticalGridHidden:YES];
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

- (IBAction)btnTap:(UIButton *)sender {

	[chartView setNeedsDisplay];

}


- (IBAction)sliderValueChanged:(UISlider *)sender {
	
	
}
@end
