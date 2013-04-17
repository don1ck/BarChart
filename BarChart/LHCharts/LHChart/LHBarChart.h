//
//  LHBarChart.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBarChart : UIScrollView

@property (nonatomic,assign) float axeStep_x;
@property (nonatomic,assign) float axeStep_y;

@property (nonatomic,assign) float offsetSide;
@property (nonatomic,assign) float offsetTop;
@property (nonatomic,assign) float offsetBottom;

@property (nonatomic,assign) float chartBarWidth;
@property (nonatomic,assign) float chartBarPointHeight;


- (id)initWithChartData:(NSDictionary*) chartData andRect:(CGRect) rect;

@end
