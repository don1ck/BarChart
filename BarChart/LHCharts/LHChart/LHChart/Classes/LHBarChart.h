//
//  LHChartView.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBar;

@interface LHBarChart : UIView

@property (nonatomic,assign) float axeStep_x;
@property (nonatomic,assign) float axeStep_y;

@property (nonatomic,assign) float chartBarWidth;
@property (nonatomic,assign) float chartBarPointHeight;

@property (nonatomic,assign) float axesWidth;

@property (nonatomic,retain) UIColor * gridColor;

@property (nonatomic,assign) BOOL isVerticalGridHidden;
@property (nonatomic,assign) BOOL isHorizontalGridHidden;

@property (nonatomic,assign) float segmentLength;


@property (nonatomic,retain) LHBar * barTemplate;

- (id)initWithChartData:(NSDictionary*) chartData andChartBar:(LHBar*) bar;

@end
