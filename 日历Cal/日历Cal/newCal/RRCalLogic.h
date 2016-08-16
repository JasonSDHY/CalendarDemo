//
//  RRCalLogic.h
//  日历Cal
//
//  Created by Jason Ding on 16/8/16.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQCalendarDay.h"
@interface RRCalLogic : NSObject

@property (nonatomic, strong) NSMutableArray *daysInPreviousMonth;
@property (nonatomic, strong) NSMutableArray *daysInCurrentMonth;
@property (nonatomic, strong) NSMutableArray *daysInFollowingMonth;

@property (nonatomic, strong) NSMutableArray *calendarDays; // 当前月份展示的日历天

/* 用户日历上的当天 */
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) WQCalendarDay *currentCalendarDay;

/* 用户点击选中的日历上的某一天 */
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) WQCalendarDay *selectedCalendarDay;

/**
 *  刷新当日所在月的信息.
 */
- (void)loadCurrentDate;

/**
 *  刷新指定日期的月份信息.
 */
- (void)reloadDate:(NSDate *)date;

/**
 *  刷新当前所选的上一个月的信息
 */
- (void)goToPreviousMonth;

/**
 *  刷新当前所选的下一个月的信息
 */
- (void)goToNextMonth;
@end
