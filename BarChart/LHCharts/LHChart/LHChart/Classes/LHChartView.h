//
//  LHChartView.h
//  LHChart
//
//  Created by Viktor on 26.04.13.
//  Copyright (c) 2013 LoneHouse. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol LHChartViewDelegate <NSObject>
-(CGRect) rectToDrawIn;
@end

@interface LHChartView : UIView
@property (nonatomic,assign) id<LHChartViewDelegate> delegate;
@property (nonatomic,assign) float chartBarWidth;
@property (nonatomic,assign) float chartBarPointHeight;
@end
