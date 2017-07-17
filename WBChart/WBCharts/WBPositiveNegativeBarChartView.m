//
//  WBPositiveNegativeBarChartView.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "WBPositiveNegativeBarChartView.h"
#import "WBBarItem.h"
#import "WBAuxiliaryCalculationHelper.h"
#import "WBPositiveNegativeBarContainerView.h"

#define AbscissaHeight 30
#define PartWidth 35.0
#define BarBackgroundFillColor [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1]

@interface WBPositiveNegativeBarChartView ()

@property (nonatomic, strong) WBPositiveNegativeBarContainerView *barPNContainerView;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;
@property (nonatomic, assign) BOOL needScroll;

@end

@implementation WBPositiveNegativeBarChartView
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<WBBarItem *> *)dataItemArray {
    if (self = [self initWithFrame:frame]) {
        
        self.dataItemArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataItemArray = dataItemArray;
        self.showsVerticalScrollIndicator = FALSE;
        self.showsHorizontalScrollIndicator = FALSE;
        self.backgroundColor = [UIColor whiteColor];
        self.contentSize = [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];
        
        [self addSubview:self.barPNContainerView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//计算是否需要滚动
- (CGSize)computeSrollViewCententSizeFromItemArray:(NSMutableArray<WBBarItem *> *)itemArray {
    
    if (itemArray.count <= 8) {
        self.needScroll = NO;
        return CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        self.needScroll = YES;
        CGFloat width = PartWidth * itemArray.count;
        CGFloat height = self.frame.size.height;
        return CGSizeMake(width, height);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (WBPositiveNegativeBarContainerView *)barPNContainerView {
    if (!_barPNContainerView) {
        _barPNContainerView = [[WBPositiveNegativeBarContainerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height - AbscissaHeight) dataItemArray:self.dataItemArray];
    }
    return _barPNContainerView;
}

@end
