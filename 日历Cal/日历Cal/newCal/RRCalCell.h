//
//  RRCalCell.h
//  日历Cal
//
//  Created by Jason Ding on 16/8/16.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQCalendarDay.h"

@interface RRCalCell : UICollectionViewCell

@property (nonatomic, strong) WQCalendarDay *calDayModel;

@end
