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


#import "LHBarChart.h"
#import "LHBar.h"

@interface LHBarChart ()
{
    float max_x;
    float max_y;
}

@property (nonatomic,retain) NSDictionary * chartData;

@end

@implementation LHBarChart

- (id)initWithChartData:(NSDictionary*) chartData andChartBar:(LHBar*) bar
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
        
        self.barTemplate = bar;
        
        self.gridColor = BACKGROUND_GRID_DEFAULT_COLOR;
        
        [self setupFrameSize];
    }
    return self;
}

- (void)setupFrameSize
{
    CGRect frame = self.bounds;
    
    frame.size.width  = self.chartBarWidth * (max_x+1);//+1 because last bar will be cutted
    frame.size.height = self.chartBarPointHeight * max_y;
    self.frame = frame;
}

#pragma mark - drawing

//Draw X and Y axes
- (void) drawAxes:(CGContextRef) context inRect:(CGRect) rect
{
    CGContextBeginPath(context);
    
    //setup axes line style
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.axesWidth);
	
	BOOL isAxisYVisible = rect.origin.x < self.segmentLength;

	if (isAxisYVisible) {
		//Getting count of Visible segments
		int drawYSegmentFrom = max_y - (rect.size.height + rect.origin.y) / self.chartBarPointHeight;
		int drawYSegmentTo = max_y - (rect.origin.y / self.chartBarPointHeight);
		
		CGContextMoveToPoint(   context, 0, viewHeight - (self.chartBarPointHeight * drawYSegmentFrom-1));
		
		//Drawing Y axe with segments. (drawYSegmentTo+1) - give extra line on the top
		for (int i = drawYSegmentFrom; i<=drawYSegmentTo+1; i++) {
			CGContextAddLineToPoint(context, 0, viewHeight - (self.chartBarPointHeight * i));
			CGContextAddLineToPoint(context, self.segmentLength, viewHeight - (self.chartBarPointHeight * i));
			CGContextMoveToPoint(   context, 0, viewHeight - (self.chartBarPointHeight * i));
		}
	}

    
    CGContextMoveToPoint(context, 0, viewHeight);
    
    //Drawing X axe. (max_y+1) - give extra line on the side
    for (int i = 1; i<=(max_x+1); i++) {
        CGContextAddLineToPoint(context, self.chartBarWidth * i, viewHeight);
        CGContextAddLineToPoint(context, self.chartBarWidth * i, viewHeight-self.segmentLength);
        CGContextMoveToPoint(   context, self.chartBarWidth * i, viewHeight);
    }
    
    CGContextClosePath(context);
}

//Draw chart by Bars
- (void) drawBarChart:(CGContextRef) context
{

    
    for (NSNumber * key in self.chartData.allKeys) {
        //this is point just above the segment
        CGPoint rootPoint = CGPointMake(self.chartBarWidth*[key intValue],viewHeight - self.segmentLength);
        
        //giving to the bar template all necessary info 
        [self.barTemplate setValue:[[self.chartData objectForKey:key] floatValue]
                         rootPoint:rootPoint
                       pointHeight:self.chartBarPointHeight
                          barWidth:self.chartBarWidth
                  andSegmentLenght:self.segmentLength];
        
        [self.barTemplate drawInContext:context];
    }
    

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
	CGRect rectToDraw = [self getRectToDrawIn];
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawAxes:context inRect:rectToDraw];
    CGContextDrawPath(context, kCGPathStroke);
    [self drawBackgroundGrid:context];
    CGContextDrawPath(context, kCGPathStroke);
    [self drawBarChart:context];
    CGContextDrawPath(context, kCGPathStroke);
}


//Force view to redraw it content
-(void) reDrawView
{
	[self setNeedsDisplay];
}

#pragma mark - memory managmetn

-(void)dealloc
{
	[super dealloc];
	[self.gridColor release];
	[self.barTemplate release];
}

#pragma mark - delegate

-(CGRect) getRectToDrawIn
{
	CGRect rect;
	if (self.delegate && [self.delegate respondsToSelector:@selector(rectToDrawIn)]) {
		rect = [self.delegate rectToDrawIn];
	} else {
		rect = self.bounds;
	}
	return rect;
}


@end
