//
//  PieDataView.h
//  Data
//
//  Created by hipiao on 16/9/1.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^cellPieBlock)(NSString* index,NSString * assetsTypeStateStr);

@interface WBPieView : UIView
{
    
    double currentAngelone;
    float floatx ;
    float floaty ;
    float floatx1 ;
    float floaty1 ;
    
    float fddx;
    float fddy;
}



@property (nonatomic,strong) CAShapeLayer * shapeLayer;
@property (nonatomic,assign) CGFloat currentAngel;
@property (nonatomic,strong) UIColor * fillColor;
@property (nonatomic,assign) CGFloat beginAngle;
@property (nonatomic,assign) CGFloat endAngle;
@property (nonatomic) float progressWidth;

@property (nonatomic,strong)cellPieBlock cellBlockXXX;

@property(nonatomic,strong) NSArray * colorArray;//数据坐标
@property(nonatomic,strong) NSArray * dataArray;//数据坐标
@property(nonatomic,strong) NSArray * nameArray;//数据坐标


@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * data;

@property (nonatomic,strong) NSArray  * arr;
@property (nonatomic,strong)NSString * idstr;

@property (nonatomic,strong)NSArray * idarray;

@property (nonatomic,strong)NSMutableArray * entityArray;
@property (nonatomic,strong)NSArray * assetsTypeStateArr;


@property (nonatomic,strong)NSString * assetsTypeStateStr;



-(void)addFansData:(NSArray *)carray dataArray:(NSArray *)darray narray:(NSArray *)narray idarray:(NSArray *)idarray assetsTypeStateArr:(NSArray *)assetsTypeStateArr;
@end
