//
//  LHBarChart.m
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#define AXE_DEFAULT_STEP 1.0

#define OFFSET_DEFAULT_SIDE 20
#define OFFSET_DEFAULT_TOP 40
#define OFFSET_DEFAULT_BOTTOM 40

#define BAR_DEFAULT_WIDTH 10
#define BAR_DEFAULT_HEIGHT 10

#import "LHBarChart.h"
#import "LHChartView.h"

@interface LHBarChart ()
{
    float max_x;
    float max_y;
}

@property (nonatomic,retain) NSDictionary * chartData;

- (void) setupContentSize;

@end

@implementation LHBarChart

- (id)initWithChartData:(NSDictionary*) chartData andRect:(CGRect) rect
{
    self = [super initWithFrame:rect];
    if (self) {
        self.chartData = chartData;
        max_x = [[self.chartData.allKeys   valueForKeyPath:@"@max.self"] floatValue];
        max_y = [[self.chartData.allValues valueForKeyPath:@"@max.self"] floatValue];
        
        self.axeStep_x = AXE_DEFAULT_STEP;
        self.axeStep_y = AXE_DEFAULT_STEP;
        
        self.offsetBottom = OFFSET_DEFAULT_BOTTOM;
        self.offsetSide = OFFSET_DEFAULT_SIDE;
        self.offsetTop = OFFSET_DEFAULT_TOP;
        
        self.chartBarPointHeight = BAR_DEFAULT_HEIGHT;
        self.chartBarWidth = BAR_DEFAULT_WIDTH;
        
        [self setupContentSize];

    }
    return self;
}

- (void) setupContentSize
{
    float contentWidth = (self.offsetSide * 2) + (self.chartBarWidth * max_x);
    float contentHeight = (self.offsetTop + self.offsetBottom) + (self.chartBarPointHeight * max_y);
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    self.contentSize = contentSize;
}

#pragma mark - drawing

// Do some drawing :)



@end
