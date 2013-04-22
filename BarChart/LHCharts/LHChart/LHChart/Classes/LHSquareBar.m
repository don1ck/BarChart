//
//  LHSquareBar.m
//  LHChart
//
//  Created by Victor on 21.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import "LHSquareBar.h"

@implementation LHSquareBar

-(void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 3);
    CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetShadow(context, CGSizeMake(20, 20), 5);
    
    CGRect barRect = CGRectMake(self.rootPoint.x-self.barWidth/4, self.rootPoint.y, self.barWidth/2, (-self.value*self.pointHeight) + self.segmentLenght);
    
    CGContextFillRect(context, barRect);

}

@end
