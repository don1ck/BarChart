//
//  LHChartView.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

enum kChartStyle {
    kChartStyleBar,
    kChartStyleLine
    };

@interface LHChartView : UIView

@property (nonatomic,assign) float axeStep_x;
@property (nonatomic,assign) float axeStep_y;

@property (nonatomic,assign) float chartBarWidth;
@property (nonatomic,assign) float chartBarPointHeight;

@property (nonatomic,assign) float axesWidth;

@property (nonatomic,retain) UIColor * gridColor;

@property (nonatomic,assign) float segmentLength;

@property (nonatomic,assign) enum kChartStyle chartStyle;

- (id)initWithChartData:(NSDictionary*) chartData;

@end
