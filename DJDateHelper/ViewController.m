//
//  ViewController.m
//  DJDateHelper
//
//  Created by Mr.Deng on 15/12/26.
//  Copyright © 2015年 Mr.Deng. All rights reserved.
//

#import "ViewController.h"


#import "DJDateHelper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *startDate = [[DJDateHelper sharedInstance] convertDateFromString:@"2015-12-30"];
    
    NSDate *endDate = [[DJDateHelper sharedInstance] convertDateFromString:@"2016-1-30"];
    
    NSLog(@"%zd", [[DJDateHelper sharedInstance] getDifferenceWithTwoData:startDate endDate:endDate]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
