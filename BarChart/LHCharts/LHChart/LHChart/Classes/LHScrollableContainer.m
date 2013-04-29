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

- (id)initWithChartView:(LHChartView*) chartView andRect:(CGRect) rect
{
    self = [super initWithFrame:rect];
    if (self) {
    
        _chartView = chartView;
		_chartView.delegate = self;

        self.offsetBottom = OFFSET_DEFAULT_BOTTOM;
        self.offsetSide = OFFSET_DEFAULT_SIDE;
        self.offsetTop = OFFSET_DEFAULT_TOP;
		
		_axisLabel_x = [[UILabel alloc] init];
		_axisLabel_y = [[UILabel alloc] init];
		
		
		self.pinchGestureRecognizer.delegate = self;
		self.pinchGestureRecognizer.delegate = self;
		[self.panGestureRecognizer addTarget:self action:@selector(handlePanGesture:)];
		[self.pinchGestureRecognizer addTarget:self action:@selector(handlePinchGesture:)];
        
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

#pragma mark - gesture managment

- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer
{
	NSLog(@"!!");

}

- (void)handlePinchGesture:(UIGestureRecognizer *)gestureRecognizer
{
	NSLog(@"---");
}


#pragma mark - gesture recognizer  delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer  shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

#pragma mark - LHChartView delegate

-(CGRect)rectToDrawIn
{
	CGRect visibleRect;
	visibleRect.origin = self.contentOffset;
	visibleRect.origin.x -= self.offsetSide;
	visibleRect.origin.y -=self.offsetTop;
	visibleRect.size = self.frame.size;
	return visibleRect;
}

@end
