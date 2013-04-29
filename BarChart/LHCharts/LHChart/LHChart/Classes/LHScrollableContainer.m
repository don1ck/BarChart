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
    self = [super init];
    if (self) {
    
        _chartView = chartView;
		_chartView.delegate = self;

        self.offsetBottom = OFFSET_DEFAULT_BOTTOM;
        self.offsetSide = OFFSET_DEFAULT_SIDE;
        self.offsetTop = OFFSET_DEFAULT_TOP;
		
		_axisLabel_x = [[UILabel alloc] init];
		_axisLabel_y = [[UILabel alloc] init];
		
		_containerView = [[UIScrollView alloc] initWithFrame:rect];
        _containerView.delegate = self;
        _containerView.minimumZoomScale = 0.5;
        _containerView.maximumZoomScale = 2;
        
        [self setupContentSize];
        [self.containerView addSubview:_chartView];
        
    }
    return self;
}

- (void) setupContentSize
{
    float contentWidth = (self.offsetSide * 2) + self.chartView.bounds.size.width;
    float contentHeight = (self.offsetTop + self.offsetBottom) + self.chartView.bounds.size.height;
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    self.containerView.contentSize = contentSize;
        CGRect frame = self.chartView.bounds;
    frame.origin.x = self.offsetSide;
    frame.origin.y = self.offsetTop;
    self.chartView.frame = frame;
}

#pragma mark - scroll view delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.chartView setNeedsDisplay];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.chartView;
}

#pragma mark - LHChartView delegate

-(CGRect)rectToDrawIn
{
	CGRect visibleRect;
	visibleRect.origin = self.containerView.contentOffset;
	visibleRect.origin.x -= self.offsetSide;
	visibleRect.origin.y -= self.offsetTop;
	visibleRect.size = self.containerView.frame.size;
    float theScale = 1.0 / self.containerView.zoomScale;
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
	return visibleRect;
}

@end
