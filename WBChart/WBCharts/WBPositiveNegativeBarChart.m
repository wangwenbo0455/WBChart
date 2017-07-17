//
//  WBPositiveNegativeBarChart.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "WBPositiveNegativeBarChart.h"
#import "WBPositiveNegativeBarChartView.h"
//#import "OrdinateView.h"
#define OrdinateWidth 30
#define BarChartViewTopInterval 10

@interface WBPositiveNegativeBarChart ()

@property (nonatomic, strong) WBPositiveNegativeBarChartView *barChartView;

@end

@implementation WBPositiveNegativeBarChart

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<WBBarItem *> *)dataItemArray {
    if (self = [super initWithFrame:frame]) {
        
        self.dataItemArray = dataItemArray;
        [self addSubview:self.barChartView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma mark Get

- (WBPositiveNegativeBarChartView *)barChartView {
    if (!_barChartView) {
        _barChartView = [[WBPositiveNegativeBarChartView alloc] initWithFrame:CGRectMake(12, BarChartViewTopInterval, self.frame.size.width -24, self.frame.size.height - BarChartViewTopInterval) dataItemArray:self.dataItemArray];
    }
    return _barChartView;
}


@end
