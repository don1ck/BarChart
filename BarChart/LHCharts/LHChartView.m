//
//  LHChartView.m
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHChartView.h"

@implementation LHChartView

- (id)initWithChartData:(NSDictionary*) chartData andRect:(CGRect) rect
{
    self = [super initWithFrame:rect];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextClearRect(context, rect);
    CGContextSetRGBFillColor(context, 255, 255, 0, 1);
    CGContextFillRect(context, CGRectMake(10, 10, 40, 50));
}

@end
