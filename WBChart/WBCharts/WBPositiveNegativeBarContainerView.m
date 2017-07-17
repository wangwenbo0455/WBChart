//
//  WBPositiveNegativeBarContainerView.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "WBPositiveNegativeBarContainerView.h"
//#import "XBarContainerView.h"
#import "WBAuxiliaryCalculationHelper.h"
//#import "XAbscissaView.h"
//#import "XColor.h"
#import "CAShapeLayer+frameCategory.h"
//#import "XAnimationLabel.h"
#import "CALayer+XXLayer.h"
//#import "XAnimation.h"
//#import "ZKFHeader.h"

#define BarBackgroundFillColor [UIColor clearColor]

#define animationDuration 3






typedef enum : NSUInteger {
    Positive,
    Negative,
} Valuence;

@interface WBPositiveNegativeBarContainerView ()

@property (nonatomic, strong) CABasicAnimation *pathAnimation;
@property (nonatomic, strong) CALayer *coverLayer;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *dataNumberArray;
//值填充
@property (nonatomic, strong) NSMutableArray<CALayer *> *layerArray;
//背景填充
@property (nonatomic, strong) NSMutableArray<CALayer *> *fillLayerArray;
@property (nonatomic,strong)UIView * Tanview ;
@property (nonatomic,assign) NSUInteger aa ;

@end

@implementation WBPositiveNegativeBarContainerView

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<WBBarItem *> *)dataItemArray  {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
//        [UIColor colorWithHexString:@"#c7ae7a"];
        self.coverLayer = [CALayer layer];
        _aa = 99999;
        self.layerArray = [[NSMutableArray alloc] init];
        self.fillLayerArray = [[NSMutableArray alloc] init];
        self.colorArray = [[NSMutableArray alloc] init];
        self.dataNumberArray = [[NSMutableArray alloc] init];
        self.dataDescribeArray = [[NSMutableArray alloc] init];
        self.dataItemArray = dataItemArray;
        [self.dataItemArray enumerateObjectsUsingBlock:^(WBBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.dataNumber > self.top) {
                self.top = obj.dataNumber;
            }
            
            if (obj.dataNumber < self.bottom) {
                self.bottom = obj.dataNumber;
            }
        }];
        CGFloat maxNum = [self.top floatValue];
        CGFloat minNum = [self.bottom floatValue];
        
        CGFloat extra = (maxNum -minNum)/(3);
        
        NSNumber * topNum = [NSNumber numberWithFloat:maxNum+extra];
        NSNumber * bottomNum = [NSNumber numberWithFloat:minNum-0.001];
        
        self.top = topNum;
        self.bottom = bottomNum;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self cleanPreDrawAndData];
    [self strokeChart];
    
}

- (void)cleanPreDrawAndData {
    
    // remove layer
    [self.coverLayer removeFromSuperlayer];
    [self.layerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    [self.fillLayerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    // clean array
    [self.layerArray removeAllObjects];
    [self.fillLayerArray removeAllObjects];
    [self.colorArray removeAllObjects];
    [self.dataNumberArray removeAllObjects];
    [self.dataDescribeArray removeAllObjects];
    
}

- (void)strokeChart {
    //从BarItem 中提取各类数据
    //防止多次调用 必须清理数据
    [self.colorArray removeAllObjects];
    [self.dataNumberArray removeAllObjects];
    [self.dataDescribeArray removeAllObjects];
    
    [self.dataItemArray enumerateObjectsUsingBlock:^(WBBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.colorArray addObject:obj.color];
        [self.dataNumberArray addObject:obj.dataNumber];
        [self.dataDescribeArray addObject:obj.dataDescribe];
    }];
    
    //绘制bar
    CGFloat width = (self.bounds.size.width / self.dataItemArray.count) / 3 * 2;
    //每个条的x坐标
    NSMutableArray<NSNumber *> *xArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(WBBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = self.bounds.size.width * [[WBAuxiliaryCalculationHelper shareCalculationHelper] calculateTheProportionOfWidthByIdx:idx count:self.dataItemArray.count];
        [xArray addObject:@(x)];
    }];
    
    //每个背景条的rect
    NSMutableArray<NSValue *> *rectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //每个背景条的高度
        CGFloat height = self.bounds.size.height;
        NSNumber *number = obj;
        CGRect rect = CGRectMake(number.doubleValue - width/2, 0, width, height);
        [rectArray addObject:[NSValue valueWithCGRect:rect]];
    }];
    
    //根据rect 绘制背景条
    [rectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = obj.CGRectValue;
        CAShapeLayer *rectShapeLayer = [self rectShapeLayerWithBounds:rect fillColor:BarBackgroundFillColor];
        [self.fillLayerArray addObject:rectShapeLayer];
        [self.layer addSublayer:rectShapeLayer];
    }];

    //fillHeightArray 是高度的绝对值
    //每个条根据数值大小填充的高度
    NSMutableArray<NSNumber *> *fillHeightArray = [[NSMutableArray alloc] init];
    [self.dataItemArray enumerateObjectsUsingBlock:^(WBBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 正负判断
        if (self.dataNumberArray[idx].doubleValue >= 0) {
            CGFloat topH = self.top.doubleValue*(self.bounds.size.height)/(self.top.doubleValue - self.bottom.doubleValue);
            CGFloat height = fabs([[WBAuxiliaryCalculationHelper shareCalculationHelper] calculateThePositiveNegativeProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:self.dataNumberArray[idx].doubleValue] * topH);
            [fillHeightArray addObject:@(height)];
        } else {
            
            CGFloat bottomH = self.bottom.doubleValue*(self.bounds.size.height)/(self.top.doubleValue - self.bottom.doubleValue);
            CGFloat height = fabs([[WBAuxiliaryCalculationHelper shareCalculationHelper] calculateThePositiveNegativeProportionOfHeightByTop:self.top.doubleValue bottom:self.bottom.doubleValue height:self.dataNumberArray[idx].doubleValue] * bottomH);
            [fillHeightArray addObject:@(height)];
        }
    }];
    //计算填充的矩形
    NSMutableArray<NSValue *> *fillRectArray = [[NSMutableArray alloc] init];
    [xArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //height - fillHeightArray[idx].doubleValue 计算起始Y...
        CGRect fillRect;
        // 正负判断,高度是否大于0
        if (self.dataNumberArray[idx].doubleValue >= 0) {
            
            CGFloat y = (self.top.doubleValue/(self.top.doubleValue - self.bottom.doubleValue))*self.bounds.size.height;
            fillRect = CGRectMake(obj.doubleValue - width/2, y - fillHeightArray[idx].doubleValue , width, fillHeightArray[idx].doubleValue);
        } else {
            CGFloat y = (self.top.doubleValue/(self.top.doubleValue - self.bottom.doubleValue))*self.bounds.size.height;
            fillRect = CGRectMake(obj.doubleValue - width/2, y, width, fillHeightArray[idx].doubleValue);
        }
        [fillRectArray addObject:[NSValue valueWithCGRect:fillRect]];
    }];

    //根据fillrect 绘制填充的fillrect 与 topLabel
    NSMutableArray *fillShapeLayerArray = [[NSMutableArray alloc] init];
    
    [fillRectArray enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect fillRect = obj.CGRectValue;
        
        CAShapeLayer *fillRectShapeLayer;
        
        if (self.dataNumberArray[idx].doubleValue >= 0) {
            fillRectShapeLayer = [self rectAnimationLayerWithBounds:fillRect fillColor:self.dataItemArray[idx].color Valuence:Positive];
        } else {
            fillRectShapeLayer = [self rectAnimationLayerWithBounds:fillRect fillColor:self.dataItemArray[idx].color Valuence:Negative];
        }
        
        if (self.dataNumberArray[idx].doubleValue >= 0) {
           
            [self viewshow:fillRect num:idx];

            
                } else {
                   }
        
        [self.layer addSublayer:fillRectShapeLayer];
        //将绘制的Layer保存
        [self.layerArray addObject:fillRectShapeLayer];
        
        [fillShapeLayerArray addObject:fillRectShapeLayer];
    }];
    
    
    for (int i =0; i<5; i++) {
        
        CGFloat y;
        y =  self.frame.size.height / (4 * 2);
        CGContextRef contentRef = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(contentRef, [UIColor lightGrayColor].CGColor);
        CGContextSetLineWidth(contentRef, 0.5);
        CGContextMoveToPoint(contentRef, 0, i * y * 2+2);
        CGContextAddLineToPoint(contentRef, self.frame.size.width+150, i * y * 2+2);
        CGContextStrokePath(contentRef);
        
        
    }
    

    
    
    
}

#pragma mark HelpMethods

- (CAShapeLayer *)rectAnimationLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    CGPoint startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y + rect.size.height));
    CGPoint endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));

    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap = kCALineCapSquare;
    chartLine.lineJoin = kCALineJoinRound;
    chartLine.lineWidth = rect.size.width;
    
    //显示的线
    CGPoint temStartPoint = CGPointMake(startPoint.x, startPoint.y + rect.size.width/2);
    CGPoint temEndPoint = CGPointMake(endPoint.x, endPoint.y + rect.size.width/2);
    UIBezierPath *temPath = [[UIBezierPath alloc] init];
    [temPath moveToPoint:temStartPoint];
    [temPath addLineToPoint:temEndPoint];
    //动画的path
    chartLine.path = temPath.CGPath;
    chartLine.strokeStart = 0.0;
    chartLine.strokeEnd = 1.0;
    chartLine.strokeColor = fillColor.CGColor;
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
    //由于CAShapeLayer.frame = (0,0,0,0) 所以用这个判断点击
    chartLine.frameValue = [NSValue valueWithCGRect:rect];
    
    chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
    return chartLine;
}

- (CAShapeLayer *)rectAnimationLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor Valuence:(Valuence)valyence {

    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint temStartPoint;
    CGPoint temEndPoint;
    BOOL canAnimation = YES;
    if (valyence == Positive) {
        //矩形中一条线path
        startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y + rect.size.height));
        endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));

        // 做不做动画
        // 由于利用starpoint endpoint 要考虑线宽
        if (rect.size.width/2 > rect.size.height/2) {
            //不做动画
            temStartPoint = CGPointMake(startPoint.x, startPoint.y);
            temEndPoint = CGPointMake(endPoint.x, endPoint.y);
            canAnimation = NO;
        } else {
            //动画path
            temStartPoint = CGPointMake(startPoint.x, startPoint.y - rect.size.width/2);
            temEndPoint = CGPointMake(endPoint.x, endPoint.y + rect.size.width/2);
        }
        
    } else {
        //动画的path
        startPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y));
        endPoint = CGPointMake(rect.origin.x + (rect.size.width) / 2, (rect.origin.y + rect.size.height));
        // 做不做动画
        // 由于利用starpoint endpoint 要考虑线宽
        if (rect.size.width/2 > rect.size.height/2) {
            temStartPoint = CGPointMake(startPoint.x, startPoint.y);
            temEndPoint = CGPointMake(endPoint.x, endPoint.y);
            canAnimation = NO;
        } else {
            temStartPoint = CGPointMake(startPoint.x, startPoint.y + rect.size.width/2);
            temEndPoint = CGPointMake(endPoint.x, endPoint.y - rect.size.width/2);
        }
    }
    
    //临时调试 以后添加动画
    canAnimation = NO;
    // 做动画 line+strokeStartEnd
    // 不做 shapelayer
    if (canAnimation) {
        CAShapeLayer *chartLine = [CAShapeLayer layer];
        chartLine.lineCap = kCALineCapSquare;
        chartLine.lineJoin = kCALineJoinRound;
        chartLine.lineWidth = rect.size.width;
        
        //显示的线
        UIBezierPath *temPath = [[UIBezierPath alloc] init];
        [temPath moveToPoint:temStartPoint];
        [temPath addLineToPoint:temEndPoint];
        
        chartLine.path = temPath.CGPath;
        chartLine.strokeStart = 0.0;
        chartLine.strokeEnd = 1.0;
        chartLine.strokeColor = fillColor.CGColor;
        [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
        //由于CAShapeLayer.frame = (0,0,0,0) 所以用这个判断点击
        chartLine.frameValue = [NSValue valueWithCGRect:rect];
        chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];
        return chartLine;
    } else {
        CAShapeLayer *noAnimationLayer = [self rectShapeLayerWithBounds:rect fillColor:fillColor];
        noAnimationLayer.frameValue = [NSValue valueWithCGRect:rect];
        noAnimationLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
        return noAnimationLayer;
    }
}

- (CAShapeLayer *)rectShapeLayerWithBounds:(CGRect)rect fillColor:(UIColor *)fillColor {
    
    //正常的
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.path = path.CGPath;
    rectLayer.fillColor   = fillColor.CGColor;
    rectLayer.path        = path.CGPath;
    rectLayer.frameValue = [NSValue valueWithCGRect:rect];
    
    return rectLayer;
}


- (CAGradientLayer *)rectGradientLayerWithBounds:(CGRect)rect {
    //颜色渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
//    gradientLayer.colors = @[(__bridge id)GradientFillColor2,(__bridge id)GradientFillColor2];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    return gradientLayer;
    
}

- (CABasicAnimation *)pathAnimation {
    _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _pathAnimation.duration = animationDuration;
    _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _pathAnimation.fromValue = @0.0f;
    _pathAnimation.toValue = @1.0f;
    return _pathAnimation;
}
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint __block point = [[touches anyObject] locationInView:self];
    //点击整个柱子
    [self.fillLayerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = (CAShapeLayer *)obj;
        CGRect layerFrame = shapeLayer.frameValue.CGRectValue;
        
        if (CGRectContainsPoint(layerFrame, point)) {
            
            //上一次点击的layer,清空上一次的状态
            CAShapeLayer *preShapeLayer =  (CAShapeLayer *)self.layerArray[self.coverLayer.selectIdxNumber.intValue];
            preShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
            [self.coverLayer removeFromSuperlayer];
            
            //得到对应 填充高度frame
            CAShapeLayer *subShapeLayer = (CAShapeLayer *)self.layerArray[idx];
            //如果已经高亮了
            if (subShapeLayer.selectStatusNumber.boolValue == YES) {
                subShapeLayer.selectStatusNumber = [NSNumber numberWithBool:NO];
                [self.coverLayer removeFromSuperlayer];
                return ;
            }
            
            BOOL boolValue = subShapeLayer.selectStatusNumber.boolValue;
            subShapeLayer.selectStatusNumber = [NSNumber numberWithBool: !boolValue];
            self.coverLayer = [self rectGradientLayerWithBounds:subShapeLayer.frameValue.CGRectValue];
            self.coverLayer.selectIdxNumber = @(idx);
            
            [subShapeLayer addSublayer:self.coverLayer];
            return ;
        }
    }];
}



-(void)viewshow:(CGRect)rect num:(NSUInteger)idx
{
   
    if (self.colorArray[idx] == [UIColor clearColor]) {
        NSLog(@"填充的");
        return;
    }
        _Tanview = [[UIView alloc]init];
    
    _Tanview.frame =CGRectMake(rect.origin.x, rect.origin.y-30, 50, 30);
    UIImageView * baview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [baview setImage:[UIImage imageNamed:@"asset_icon_popup"]];
    [_Tanview addSubview:baview];
    _Tanview.center = CGPointMake(rect.origin.x+rect.size.width/2,  rect.origin.y-15);
    
    
    
    UILabel * oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,50, 20)];
    oneLabel.text = [NSString stringWithFormat:@"%@%%",self.dataNumberArray[idx]];
    oneLabel.textColor = [UIColor redColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:10];
    [_Tanview addSubview:oneLabel];
    
    
    [self addSubview:_Tanview];
}



@end
