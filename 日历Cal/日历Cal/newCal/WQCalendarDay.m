//
//  WQCalendarDay.m
//  WQCalendar
//
//  Created by Jason Lee on 14-3-4.
//  Copyright (c) 2014年 Jason Lee. All rights reserved.
//

#import "WQCalendarDay.h"

@implementation WQCalendarDay


+ (WQCalendarDay *)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day
{
    WQCalendarDay *calendarDay = [[WQCalendarDay alloc] init];
    calendarDay.year = year;
    calendarDay.month = month;
    calendarDay.day = day;
    return calendarDay;
}

- (BOOL)isEqualTo:(WQCalendarDay *)day
{
    BOOL isEqual = (self.year == day.year) && (self.month == day.month) && (self.day == day.day);
    return isEqual;
}

- (NSDate *)date
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.year = self.year;
    c.month = self.month;
    c.day = self.day;
    
    
    
    NSDate *newdate = [[NSCalendar currentCalendar] dateFromComponents:c];
    
    // 修正时区, 修复字段和date不一致的问题.
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: newdate];
    return [newdate  dateByAddingTimeInterval: interval];
    
}

- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self.date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
/**
 *  判断某个时间是否为当月
 */
- (BOOL)isCurrentMonth
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    
    NSString *dateStr = [fmt stringFromDate:self.date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

/**
 *  是否为相同月
 */
- (BOOL)isSameMonthWithDate:(NSDate *)date{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    
    NSString *dateStr = [fmt stringFromDate:self.date];
    NSString *nowStr = [fmt stringFromDate:date];
    
    return [dateStr isEqualToString:nowStr];
}

@end
