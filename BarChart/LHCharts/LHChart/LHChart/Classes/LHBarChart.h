//
//  LHBarChart.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHChartView;

@interface LHBarChart : UIScrollView



@property (nonatomic,assign) float offsetSide;
@property (nonatomic,assign) float offsetTop;
@property (nonatomic,assign) float offsetBottom;



@property (nonatomic,readonly) LHChartView * chartView;

- (id)initWithChartData:(NSDictionary*) chartData andRect:(CGRect) rect;

@end
