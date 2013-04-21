//
//  LHDefaultBar.m
//  LHChart
//
//  Created by Victor on 21.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHBar.h"

@implementation LHBar


//This is all what we need to draw bar in chart.
- (void)setValue:(float) value rootPoint:(CGPoint) rootPoint pointHeight:(float)pointHeight barWidth:(float)barWidth andSegmentLenght:(float) segmentLeght
{
    self.value       = value; //actually the value that needs to be desplayed on the chart
    self.rootPoint   = rootPoint; //Point just above segment in chart. This is center bottom point in bar
    self.pointHeight = pointHeight; //height of bar for value 1
    self.barWidth    = barWidth; // bar width :)
    self.segmentLenght = segmentLeght;
}


-(void) drawInContext:(CGContextRef) context{}

@end
