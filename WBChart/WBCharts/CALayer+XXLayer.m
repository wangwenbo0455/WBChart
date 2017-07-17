//
//  CALayer+XXLayer.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "CALayer+XXLayer.h"
#import <objc/runtime.h>
@implementation CALayer (XXLayer)

//selectIdx
static char kSelectIdxNumber;

- (void)setSelectIdxNumber:(id)selectIdxNumber {
    objc_setAssociatedObject(self, &kSelectIdxNumber, selectIdxNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)selectIdxNumber {
    return objc_getAssociatedObject(self, &kSelectIdxNumber);
}

@end
