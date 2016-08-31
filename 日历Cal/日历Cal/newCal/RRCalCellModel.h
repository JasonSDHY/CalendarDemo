//
//  RRCalCellModel.h
//  日历Cal
//
//  Created by Jason Ding on 16/8/31.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQCalendarDay.h"

typedef NS_ENUM(NSUInteger, KJCurrentDayPracticeState) {
    KJCurrentDayPracticeStateUnDo,
    KJCurrentDayPracticeStateSuccess,
    KJCurrentDayPracticeStateWrong
};

@interface RRCalCellModel : NSObject

@property (nonatomic, strong) WQCalendarDay *dayModel;
@property (nonatomic, assign) KJCurrentDayPracticeState dayState;

@end
