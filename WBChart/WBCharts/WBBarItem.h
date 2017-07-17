//
//  WBBarItem.h
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBBarItem : NSObject
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSNumber *dataNumber;
@property (nonatomic, strong) NSString *dataDescribe;

/**
 设置数据item

 @param dataNumber (NSNumber *)dataNumber
 @param color (UIColor *)color
 @param dataDescribe (NSString *)dataDescribe
 @return instancetype
 */
- (instancetype)initWithDataNumber:(NSNumber *)dataNumber color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;

@end
