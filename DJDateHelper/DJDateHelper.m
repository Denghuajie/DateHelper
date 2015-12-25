//
//  DJDateHelper.m
//  DJDateHelper
//
//  Created by Mr.Deng on 15/12/26.
//  Copyright © 2015年 Mr.Deng. All rights reserved.
//

#import "DJDateHelper.h"


static DJDateHelper *instance = nil;

@implementation DJDateHelper

// 单例对象
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DJDateHelper alloc] init];
    });
    return instance;
}

#pragma mark - date

//给定两个日期，计算差值
- (NSInteger)getDifferenceWithTwoData:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSTimeInterval seconds = [endDate timeIntervalSinceDate:startDate];
    
   return  seconds / (24*60*60);
    
}


//NSDate转NSString
- (NSString *)dateToString:(NSDate *)date
{
    // 格式化时间对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    // 转换时间格式
    return [formatter stringFromDate:date];
}

// 根据日期计算是周几
- (NSInteger)currentWeekDayThisWeek:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    if ([[dateFormatter stringFromDate:date] isEqualToString:@"周一"]) {
        return 1;
    }else if([[dateFormatter stringFromDate:date] isEqualToString:@"周二"]) {
        return 2;
    }else if([[dateFormatter stringFromDate:date] isEqualToString:@"周三"]) {
        return 3;
    }else if([[dateFormatter stringFromDate:date] isEqualToString:@"周四"]) {
        return 4;
    }else if([[dateFormatter stringFromDate:date] isEqualToString:@"周五"]) {
        return 5;
    }
    else if([[dateFormatter stringFromDate:date] isEqualToString:@"周六"]) {
        return 6;
    }
    else if([[dateFormatter stringFromDate:date] isEqualToString:@"周日"]) {
        return 7;
    }
    return -1;
    
}

//将当前日期转换为那一周周一的日期
- (NSDate *)getMondayDate:(NSDate *)date
{
    NSInteger currentWeekDay = [self currentWeekDayThisWeek:date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    components.day -= (currentWeekDay - 2);
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

//NSString转NSDate
- (NSDate*) convertDateFromString:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    return [self getLocalTime:date];
}

//转换成当地时间
- (NSDate *)getLocalTime:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}


//日期对应第几天
- (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//对应第几个月
- (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

//对应年份
- (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

//这个月的第一天
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//这个月一共多少天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

//上个月多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

//计算上个月的日期
- (NSDate *)lastMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//计算下个月的日期
- (NSDate*)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

// 当前是第几周
- (NSInteger)currentWeekOfThisMonth:(NSDate *)date
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
}

//计算上周的日期
- (NSDate *)lastWeek:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekOfMonth = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

//计算下周的日期
- (NSDate*)nextWeek:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekOfMonth = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

@end
