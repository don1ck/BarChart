//
//  LHScrollableContainer.h
//  BarChart
//
//  Created by Victor on 17.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHBarChart;

@interface LHScrollableContainer : UIScrollView



@property (nonatomic,assign) float offsetSide;
@property (nonatomic,assign) float offsetTop;
@property (nonatomic,assign) float offsetBottom;



@property (nonatomic,readonly) UIView * chartView;

- (id)initWithChartView:(UIView*) chartView andRect:(CGRect) rect;

@end
