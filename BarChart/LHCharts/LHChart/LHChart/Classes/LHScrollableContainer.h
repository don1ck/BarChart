//
//  LHScrollableContainer.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHChartView.h"
@class LHBarChart;


@interface LHScrollableContainer : NSObject <UIScrollViewDelegate,LHChartViewDelegate>

@property (nonatomic,assign) float offsetSide;
@property (nonatomic,assign) float offsetTop;
@property (nonatomic,assign) float offsetBottom;

@property (nonatomic,readonly) UILabel * axisLabel_x;
@property (nonatomic,readonly) UILabel * axisLabel_y;

@property (nonatomic,readonly) UIScrollView * containerView;

@property (nonatomic,readonly) LHChartView * chartView;

- (id)initWithChartView:(LHChartView*) chartView andRect:(CGRect) rect;

@end
