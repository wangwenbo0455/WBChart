//
//  WBPieView.m
//  WBChart
//
//  Created by 王文博 on 16/12/20.
//  Copyright © 2016年 王文博. All rights reserved.
//

#import "WBPieView.h"
@implementation WBPieView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}
-(void)addFansData:(NSArray *)carray dataArray:(NSArray *)darray narray:(NSArray *)narray idarray:(NSArray *)idarray assetsTypeStateArr:(NSArray *)assetsTypeStateArr{
    
    self.arr = darray;
    self.idarray = idarray;
    self.colorArray = carray;
    self.assetsTypeStateArr = assetsTypeStateArr;
    NSMutableArray * aarray = [NSMutableArray array];
    float AllData = 0.0;
    for (int i = 0; i<darray.count; i++) {//求和
        AllData = AllData+[[darray objectAtIndex:i] floatValue];
    }
    for (int i = 0; i<darray.count; i++) {//求百分比】
        CGFloat cdata;
        cdata = [[darray objectAtIndex:i] floatValue];
        [aarray addObject:[NSString stringWithFormat:@"%f",cdata/AllData]];
    }
    NSLog(@"%@",aarray);
    for (int i = 0; i<carray.count; i++) {
        if (i<carray.count-1) {
            CGFloat aa =self.currentAngel+[[aarray objectAtIndex:i]floatValue]*M_PI*2;
            self.beginAngle = self.currentAngel;
            self.endAngle   = aa;
            self.fillColor  = [carray objectAtIndex:i];
            self.name       = [narray objectAtIndex:i];
            self.data       = [aarray objectAtIndex:i];
            NSLog(@"%@",_data);
            self.idstr      = [idarray objectAtIndex:i];
            self.assetsTypeStateStr = [assetsTypeStateArr objectAtIndex:i];
            self.dataArray = aarray;
            currentAngelone = _beginAngle+(_endAngle-_beginAngle)/2;
            floatx = 100.0 * sin(currentAngelone);
            floaty = 100.0 * cos(currentAngelone);
            floatx1 = 90.0 * sin(currentAngelone);
            floaty1 = 90.0 * cos(currentAngelone);
            CGFloat chuan = _endAngle - _beginAngle;
            [self configBaseLayerididid:i :chuan];
            self.currentAngel = self.currentAngel + [[aarray objectAtIndex:i]floatValue]*M_PI*2 ;
        }else{
            CGFloat aa =self.currentAngel+[[aarray objectAtIndex:i]floatValue]*M_PI*2;
            self.beginAngle = self.currentAngel;
            self.endAngle   = aa;
            self.fillColor  = [carray objectAtIndex:i];
            self.name       = [narray objectAtIndex:i];
            self.data       = [aarray objectAtIndex:i];
            NSLog(@"%@",_data);
            self.idstr      = [idarray objectAtIndex:i];
            self.assetsTypeStateStr = [assetsTypeStateArr objectAtIndex:i];
            self.dataArray = aarray;
            currentAngelone = _beginAngle+(_endAngle-_beginAngle)/2;
            floatx = 100.0 * sin(currentAngelone);
            floaty = 100.0 * cos(currentAngelone);
            floatx1 = 90.0 * sin(currentAngelone);
            floaty1 = 90.0 * cos(currentAngelone);
            fddx = 10 * sin(currentAngelone);
            fddy = 10 * cos(currentAngelone);
            CGFloat chuan = _endAngle - _beginAngle;
            
            [self configBaseLayerididid:i :chuan];
            
        }
    }
}
- (void)configBaseLayerididid:(int)idstrrr :(CGFloat )hehe{
    _shapeLayer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:40 startAngle:_beginAngle endAngle:_endAngle clockwise:YES];;
    _shapeLayer.path        = path.CGPath;
    _shapeLayer.lineWidth   = 80;
    _shapeLayer.strokeColor = _fillColor.CGColor;
    _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_shapeLayer];
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basic.duration  = 1.1;
    basic.fromValue = @(0.1f);
    basic.toValue   = @(1.0f);
    [_shapeLayer addAnimation:basic forKey:@"basic"];
    
    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 0, 0)];
    [lb setTextAlignment:NSTextAlignmentCenter];
    lb.font = [UIFont systemFontOfSize:12];
    lb.textColor = _fillColor;
    lb.text = [NSString stringWithFormat:@"%.2f%%",[self.data floatValue]*100];
    [self addSubview:lb];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 0, 0)];
    //    image.backgroundColor = [UIColor brownColor];
//    [image sd_setImageWithURL:[NSURL URLWithString:self.name] placeholderImage:nil options:4];
    NSLog(@"%@",self.name);
    [self addSubview:image];
    

    
    
    [UIView animateWithDuration:1.5 animations:^{
        lb.frame  = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 50, 20);
        image.frame  = CGRectMake(self.frame.size.width/2-60, self.frame.size.height/2, 14, 13);
        if (currentAngelone>=0&&currentAngelone<M_PI/2) {//第四象限
            lb.center = CGPointMake(self.frame.size.width/2+floaty+23,self.frame.size.height/2+floatx);
            image.center = CGPointMake(self.frame.size.width/2+floaty+53,self.frame.size.height/2+floatx);
            NSLog(@"444 %@",self.name);
        }
        if (currentAngelone>=M_PI/2&&currentAngelone<M_PI) {//第三象限
            
            
            lb.center = CGPointMake(self.frame.size.width/2+floaty-23,self.frame.size.height/2+floatx);
            image.center = CGPointMake(self.frame.size.width/2+floaty-56,self.frame.size.height/2+floatx);
            NSLog(@"333 %@",self.name);
            
        }
        if (currentAngelone>=M_PI&&currentAngelone<M_PI*3/2) {//第二象限
            
            
            
            lb.center = CGPointMake(self.frame.size.width/2+floaty-23,self.frame.size.height/2+floatx);
            image.center = CGPointMake(self.frame.size.width/2+floaty-53,self.frame.size.height/2+floatx);
            NSLog(@"2222%@",self.name);
            
        }
        if (currentAngelone>=M_PI*3/2&&currentAngelone<M_PI*2) {//第一象限
            
            
            lb.center = CGPointMake(self.frame.size.width/2+floaty+23,self.frame.size.height/2+floatx);
            image.center = CGPointMake(self.frame.size.width/2+floaty+53,self.frame.size.height/2+floatx);
            NSLog(@"1111%@",self.name);
        }
        
    }];
    
}



- (void)drawRect:(CGRect)rect
{
    
    NSMutableArray * aarray = [NSMutableArray array];
    float AllData = 0.0;
    for (int i = 0; i<_arr.count; i++) {//求和
        AllData = AllData+[[_arr objectAtIndex:i] floatValue];
    }
    for (int i = 0; i<_arr.count; i++) {//求百分比】
        CGFloat cdata;
        cdata = [[_arr objectAtIndex:i] floatValue];
        [aarray addObject:[NSString stringWithFormat:@"%f",cdata/AllData]];
    }
    NSLog(@"%@",aarray);
    CGFloat currentAngel1 = 0.0;
    CGFloat begin1;
    CGFloat end1;
    for (int i = 0; i<_arr.count; i++) {
        CGFloat aa =currentAngel1+[[aarray objectAtIndex:i]floatValue]*M_PI*2;
        begin1 = currentAngel1;
        end1   = aa;
        
        currentAngelone = begin1+(end1-begin1)/2;
        floatx = 100.0 * sin(currentAngelone);
        floaty = 100.0 * cos(currentAngelone);
        floatx1 = 90.0 * sin(currentAngelone);
        floaty1 = 90.0 * cos(currentAngelone);
        currentAngel1 = currentAngel1 + [[aarray objectAtIndex:i]floatValue]*M_PI*2 ;
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSLog(@"%@",context);
        CGContextSetLineWidth(context,0.5);//线宽度
        UIColor * file = _colorArray[i];
        CGContextSetStrokeColorWithColor(context,file.CGColor);
        
        CGContextMoveToPoint(context, self.frame.size.width/2+floaty1,self.frame.size.height/2+floatx1);//起点
        CGContextAddLineToPoint(context, self.frame.size.width/2+floaty,self.frame.size.height/2+floatx);
        CGContextStrokePath(context);
    }
}


@end
