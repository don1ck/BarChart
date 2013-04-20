//
//  LHChartView.m
//  LHChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#define AXE_DEFAULT_STEP 1.0
#define AXE_DEFAULT_WIDTH 3

#define BAR_DEFAULT_WIDTH 60
#define BAR_DEFAULT_HEIGHT 40

#define SEGMENT_DEFAULT_LENGTH 6

#define BACKGROUND_GRID_DEFAULT_LINE_WIDTH 1
#define BACKGROUND_GRID_DEFAULT_COLOR [UIColor grayColor]



#import "LHChartView.h"

@interface LHChartView ()
{
    float max_x;
    float max_y;
}

@property (nonatomic,retain) NSDictionary * chartData;

@end

@implementation LHChartView

- (id)initWithChartData:(NSDictionary*) chartData
{
    self = [super init];
    if (self) {
        
        self.chartData = chartData;
        max_x = [[self.chartData.allKeys   valueForKeyPath:@"@max.self"] floatValue];
        max_y = [[self.chartData.allValues valueForKeyPath:@"@max.self"] floatValue];
        
        self.axeStep_x = AXE_DEFAULT_STEP;
        self.axeStep_y = AXE_DEFAULT_STEP;
        
        self.chartBarPointHeight = BAR_DEFAULT_HEIGHT;
        self.chartBarWidth       = BAR_DEFAULT_WIDTH;
        
        self.segmentLength = SEGMENT_DEFAULT_LENGTH;
        
        self.axesWidth = AXE_DEFAULT_WIDTH;
        
        self.chartStyle = kChartStyleBar;
        
        self.gridColor = BACKGROUND_GRID_DEFAULT_COLOR;
        
        [self setupFrameSize];
    }
    return self;
}

- (void)setupFrameSize
{
    CGRect frame = self.frame;
    
    frame.size.width  = self.chartBarWidth * max_x+100;
    frame.size.height = self.chartBarPointHeight * max_y+100;
    self.frame = frame;
}

#pragma mark - drawing

//Draw X and Y axes
- (void) drawAxes:(CGContextRef) context
{
    CGContextBeginPath(context);
    
    //setup axes line style
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.axesWidth);

    
    float viewHeight = self.bounds.size.height;
    
    CGContextMoveToPoint(context, 0, viewHeight);
    
    //Drawing Y axe with segments 
    for (int i = 1; i<=max_y; i++) {
        CGContextAddLineToPoint(context, 0, viewHeight - (self.chartBarPointHeight * i));
        CGContextAddLineToPoint(context, self.segmentLength, viewHeight - (self.chartBarPointHeight * i));
        CGContextMoveToPoint(   context, 0, viewHeight - (self.chartBarPointHeight * i));
    }
    
    CGContextMoveToPoint(context, 0, viewHeight);
    
    //Drawing X axe
    for (int i = 1; i<=max_x; i++) {
        CGContextAddLineToPoint(context, self.chartBarWidth * i, viewHeight);
        CGContextAddLineToPoint(context, self.chartBarWidth * i, viewHeight-self.segmentLength);
        CGContextMoveToPoint(   context, self.chartBarWidth * i, viewHeight);
    }
    
    CGContextClosePath(context);
}

//Draw chart by Bars
- (void) drawBarChart:(CGContextRef) context
{
    CGContextBeginPath(context);
    
    
    CGContextClosePath(context);
}

- (void) drawBackgroundGrid: (CGContextRef) context
{
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, BACKGROUND_GRID_DEFAULT_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    float viewHeight = self.bounds.size.height;
    float viewWidth  = self.bounds.size.width;
    
    //Draw horizontal lines
    for (int i = 1; i <= max_y; i++) {
        CGContextMoveToPoint(   context, 0, viewHeight - (self.chartBarPointHeight * i));
        CGContextAddLineToPoint(context, viewWidth, viewHeight - (self.chartBarPointHeight * i));
        //CGContextMoveToPoint(   context, 0, viewHeight - (self.chartBarPointHeight * i));
    }
    
    CGContextClosePath(context);
}


- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawAxes:context];
    CGContextDrawPath(context, kCGPathStroke);
    [self drawBackgroundGrid:context];
    CGContextDrawPath(context, kCGPathStroke);
    
    
    switch (self.chartStyle) {
        case kChartStyleBar:
            
            break;
            
        default:
            NSAssert(YES, @"Wrong enum value :(");
            break;
    }
    
 
    
    
}

@end
