//
//  DJDateHelper.h
//  DJDateHelper
//
//  Created by Mr.Deng on 15/12/26.
//  Copyright © 2015年 Mr.Deng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DJDateHelper : NSObject


// 单例对象
+ (instancetype)sharedInstance;

- (NSInteger)getDifferenceWithTwoData:(NSDate *)startDate endDate:(NSDate *)endDate;

//NSDate转NSString
- (NSString *)dateToString:(NSDate *)date;

// 根据日期计算是周几
- (NSInteger)currentWeekDayThisWeek:(NSDate *)date;

//将当前日期转换为那一周周一的日期
- (NSDate *)getMondayDate:(NSDate *)date;

//当前是第几周
- (NSInteger)currentWeekOfThisMonth:(NSDate *)date;

//计算上周的日期
- (NSDate *)lastWeek:(NSDate *)date;

//计算下周的日期
- (NSDate*)nextWeek:(NSDate *)date;

//NSString转NSDate
- (NSDate*) convertDateFromString:(NSString*)dateStr;

//转换成当地时间
- (NSDate *)getLocalTime:(NSDate *)date;

//日期对应第几天
- (NSInteger)day:(NSDate *)date;

//对应第几个月
- (NSInteger)month:(NSDate *)date;

//对应年份
- (NSInteger)year:(NSDate *)date;

//这个月的第一天
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

//这个月一共多少天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date;

//上个月多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;

//计算上个月的日期
- (NSDate *)lastMonth:(NSDate *)date;

//计算下个月的日期
- (NSDate*)nextMonth:(NSDate *)date;


@end
