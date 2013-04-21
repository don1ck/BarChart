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


#define viewHeight self.bounds.size.height
#define viewWidth self.bounds.size.width


#import "LHChartView.h"
#import "LHDefaultBar.h"

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
        
        self.barTemplate = [[LHDefaultBar alloc] init];
        [self.barTemplate release];
        
        self.gridColor = BACKGROUND_GRID_DEFAULT_COLOR;
        
        [self setupFrameSize];
    }
    return self;
}

- (void)setupFrameSize
{
    CGRect frame = self.frame;
    
    frame.size.width  = self.chartBarWidth * max_x;
    frame.size.height = self.chartBarPointHeight * max_y;
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
    
    CGPathRef path;
    for (NSNumber * key in self.chartData.allKeys) {
        CGPoint rootPoint = CGPointMake(self.chartBarWidth*[key intValue],viewHeight - self.segmentLength);
        path = [self.barTemplate pathOfBarInContext:context
                                    forValue:[[self.chartData objectForKey:key] floatValue]
                                    withRootPoint:rootPoint
                                    pointHeight:self.chartBarPointHeight
                                    andBarWidth:self.chartBarWidth];
    }
    
    CGContextClosePath(context);
}

//Drawing background grid with dash line
- (void) drawBackgroundGrid: (CGContextRef) context
{
    CGContextBeginPath(context);
    
    //setup dash line of background grid
    CGContextSetLineWidth(context, BACKGROUND_GRID_DEFAULT_LINE_WIDTH);
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGFloat lengths[] = {1,6};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    
    //Draw horizontal lines if needed
    for (int i = 1; i <= (self.isHorizontalGridHidden?0:max_y); i++) {
        CGContextMoveToPoint   (context, 0, viewHeight - (self.chartBarPointHeight * i));
        CGContextAddLineToPoint(context, self.chartBarWidth * max_x, viewHeight - (self.chartBarPointHeight * i));
    }
    
    //Draw vertical lines if needed
    for (int i = 1; i <= (self.isVerticalGridHidden?0:max_x); i++) {
        CGContextMoveToPoint(   context, self.chartBarWidth * i, viewHeight);
        CGContextAddLineToPoint(context, self.chartBarWidth * i, viewHeight - (self.chartBarPointHeight * max_y));
    }
    
    CGContextMoveToPoint(context, 0, 0);
    CGContextClosePath(context);
}


- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawAxes:context];
    CGContextDrawPath(context, kCGPathStroke);
    [self drawBackgroundGrid:context];
    CGContextDrawPath(context, kCGPathStroke);
    
}

@end
