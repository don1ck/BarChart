//
//  LHDefaultBar.h
//  LHChart
//
//  Created by Victor on 21.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBar : NSObject

@property (nonatomic,assign) float value;
@property (nonatomic,assign) CGPoint rootPoint;
@property (nonatomic,assign) float pointHeight;
@property (nonatomic,assign) float barWidth;
@property (nonatomic,assign) float segmentLenght;

- (void)setValue:(float) value rootPoint:(CGPoint) rootPoint pointHeight:(float)pointHeight barWidth:(float)barWidth andSegmentLenght:(float) segmentLeght;

-(void) drawInContext:(CGContextRef) context;
@end
