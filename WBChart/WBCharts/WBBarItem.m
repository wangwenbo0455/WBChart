//
//  WBBarItem.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "WBBarItem.h"

@implementation WBBarItem

- (instancetype)initWithDataNumber:(NSNumber *)dataNumber color:(UIColor *)color dataDescribe:(NSString *)dataDescribe {
    if (self = [super init]) {
        self.dataNumber = dataNumber;
        self.color = color;
        self.dataDescribe = dataDescribe;
    }
    return self;
}
@end
