//
//  RRCalLogic.m
//  日历Cal
//
//  Created by Jason Ding on 16/8/16.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import "RRCalLogic.h"
#import "NSDate+WQCalendarLogic.h"

@implementation RRCalLogic

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadCurrentDate];
    }
    return self;
}


- (void)loadCurrentDate{
    [self reloadDate:nil];
}
- (void)reloadDate:(NSDate *)date
{
    [self reloadCurrentDate];
    if (date == nil) date = self.currentDate;
    [self reloadCalendarDataWithDate:date];
}

- (void)reloadCalendarDataWithDate:(NSDate *)date
{
    self.selectedDate = date;
    
    NSDateComponents *c = [date YMDComponents];
    self.selectedCalendarDay = [WQCalendarDay calendarDayWithYear:c.year month:c.month day:c.day];
    
    NSUInteger weeksCount = [date numberOfWeeksInCurrentMonth];
    self.calendarDays = [NSMutableArray arrayWithCapacity:weeksCount * 7];
    
    [self calculateDaysInPreviousMonthWithDate:date];
    [self calculateDaysInCurrentMonthWithDate:date];
    [self calculateDaysInFollowingMonthWithDate:date];
}

#pragma mark - method to calculate days in previous, current and the following month.

- (void)calculateDaysInPreviousMonthWithDate:(NSDate *)date
{
    NSUInteger weeklyOrdinality = [[date firstDayOfCurrentMonth] weeklyOrdinality];
    NSDate *dayInThePreviousMonth = [date dayInThePreviousMonth];
    
    NSUInteger daysCount = [dayInThePreviousMonth numberOfDaysInCurrentMonth];
    NSUInteger partialDaysCount = weeklyOrdinality - 1;
    
    NSDateComponents *components = [dayInThePreviousMonth YMDComponents];
    
    self.daysInPreviousMonth = [NSMutableArray arrayWithCapacity:partialDaysCount];
    for (NSUInteger i = daysCount - partialDaysCount + 1; i < daysCount + 1; ++i) {
        WQCalendarDay *calendarDay = [WQCalendarDay calendarDayWithYear:components.year month:components.month day:i];
        [self.daysInPreviousMonth addObject:calendarDay];
        [self.calendarDays addObject:calendarDay];
    }
}

- (void)calculateDaysInCurrentMonthWithDate:(NSDate *)date
{
    NSUInteger daysCount = [date numberOfDaysInCurrentMonth];
    NSDateComponents *components = [date YMDComponents];
    
    self.daysInCurrentMonth = [NSMutableArray arrayWithCapacity:daysCount];
    for (int i = 1; i < daysCount + 1; ++i) {
        WQCalendarDay *calendarDay = [WQCalendarDay calendarDayWithYear:components.year month:components.month day:i];
        [self.daysInCurrentMonth addObject:calendarDay];
        [self.calendarDays addObject:calendarDay];
    }
}

- (void)calculateDaysInFollowingMonthWithDate:(NSDate *)date
{
    // NSUInteger weeklyOrdinality = [[date lastDayOfCurrentMonth] weeklyOrdinality];
    //    if (weeklyOrdinality == 7) return ;
    
    NSUInteger partialDaysCount = 14 ;
    NSDateComponents *components = [[date dayInTheFollowingMonth] YMDComponents];
    
    self.daysInFollowingMonth = [NSMutableArray arrayWithCapacity:partialDaysCount];
    for (int i = 1; i < partialDaysCount + 1; ++i) {
        WQCalendarDay *calendarDay = [WQCalendarDay calendarDayWithYear:components.year month:components.month day:i];
        [self.daysInFollowingMonth addObject:calendarDay];
        [self.calendarDays addObject:calendarDay];
    }
}
- (void)reloadCurrentDate
{
    self.currentDate = [NSDate date];
    
    NSDateComponents *c = [self.currentDate YMDComponents];
    self.currentCalendarDay = [WQCalendarDay calendarDayWithYear:c.year month:c.month day:c.day];
}

#pragma mark -

- (void)goToPreviousMonth
{
    self.selectedDate = [self.selectedDate dayInThePreviousMonth];
    [self reloadDate:self.selectedDate];
}

- (void)goToNextMonth
{
    self.selectedDate = [self.selectedDate dayInTheFollowingMonth];
    [self reloadDate:self.selectedDate];
}

@end
