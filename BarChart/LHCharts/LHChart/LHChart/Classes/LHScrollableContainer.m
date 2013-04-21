//
//  LHScrollableContainer.m
//  LHChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#define OFFSET_DEFAULT_SIDE 20
#define OFFSET_DEFAULT_TOP 10
#define OFFSET_DEFAULT_BOTTOM 20



#import "LHScrollableContainer.h"
#import "LHBarChart.h"

@interface LHScrollableContainer ()
{
}

- (void) setupContentSize;

@end

@implementation LHScrollableContainer

- (id)initWithChartView:(UIView*) chartView andRect:(CGRect) rect
{
    self = [super initWithFrame:rect];
    if (self) {
    
        _chartView = chartView;

        self.offsetBottom = OFFSET_DEFAULT_BOTTOM;
        self.offsetSide = OFFSET_DEFAULT_SIDE;
        self.offsetTop = OFFSET_DEFAULT_TOP;
        
        [self setupContentSize];
        [self addSubview:_chartView];
        
    }
    return self;
}

- (void) setupContentSize
{
    float contentWidth = (self.offsetSide * 2) + self.chartView.bounds.size.width;
    float contentHeight = (self.offsetTop + self.offsetBottom) + self.chartView.bounds.size.height;
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    self.contentSize = contentSize;
    
    CGRect frame = self.chartView.bounds;
    frame.origin.x = self.offsetSide;
    frame.origin.y = self.offsetTop;
    self.chartView.frame = frame;
}




@end
