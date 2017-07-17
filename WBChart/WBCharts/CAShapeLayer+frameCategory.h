//
//  CAShapeLayer+frameCategory.h
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (frameCategory)

@property (nonatomic, strong) NSValue *frameValue;
@property (nonatomic, strong) NSValue *backgroundFrameValue;
@property (nonatomic, strong) NSNumber *selectStatusNumber;


@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSValue *> *> *segementPointsArrays;

@end
