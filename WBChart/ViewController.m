//
//  ViewController.m
//  WBChart
//
//  Created by 王文博 on 2017/7/17.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "ViewController.h"
#import "WBBarItem.h"
#import "WBPositiveNegativeBarChart.h"
#import "WBPieView.h"
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];

    
    for (int i = 0; i<13; i++) {
        
        int y = (arc4random() % 150) + 100;
        NSString * dataStr = [NSString stringWithFormat:@"%d",y];
        WBBarItem *item1 = [[WBBarItem alloc] initWithDataNumber:@([dataStr floatValue]) color:[UIColor redColor] dataDescribe:@""];
        [itemArray addObject:item1];
    }

    
    
    WBPositiveNegativeBarChart *barChart = [[WBPositiveNegativeBarChart alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 235) dataItemArray:itemArray];
    
    
    [self.view addSubview:barChart];
    
    NSMutableArray * colorArraym = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * dataArraym = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * nameArraym = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * IdArraym = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * assetsTypeStat = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i<5; i++) {
        [colorArraym addObject:randomColor];
        [dataArraym addObject:@"10"];
        [nameArraym addObject:@"10"];

        [IdArraym addObject:@"10"];
        [assetsTypeStat addObject:@"10"];
    }
    WBPieView * pieView = [[WBPieView alloc]initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, 250)];
     [pieView addFansData:colorArraym dataArray:dataArraym narray:nameArraym idarray:itemArray assetsTypeStateArr:assetsTypeStat];
    
    [self.view addSubview:pieView];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
