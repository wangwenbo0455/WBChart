//
//  WBPositiveNegativeBarChart.h
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBBarItem.h"

@interface WBPositiveNegativeBarChart : UIView
/**
 初始化方法
 
 @param frame frame
 @param dataItemArray items
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<WBBarItem *> *)dataItemArray;

/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray<WBBarItem *> *dataItemArray;

/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;
@end
