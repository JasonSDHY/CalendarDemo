//
//  NSDate+WQCalendarLogic.h
//  WQCalendar
//
//  Created by Jason Lee on 14-3-4.
//  Copyright (c) 2014年 Jason Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)numberOfWeeksInCurrentMonth;

- (NSUInteger)weeklyOrdinality;

- (NSUInteger)monthlyOrdinality;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;

- (NSDateComponents *)YMDComponents;

- (NSUInteger)weekNumberInCurrentMonth;

/**
 *  修正NSDate的时区
 */
- (NSDate *)fixSystemTimeZone;
/**
 *  判断传入的日期是这个日期之后的日期.
 */
- (BOOL)isFutureDayWithDate:(NSDate *)date;
@end
