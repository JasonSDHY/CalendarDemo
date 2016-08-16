//
//  RRCalCell.m
//  日历Cal
//
//  Created by Jason Ding on 16/8/16.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import "RRCalCell.h"
@interface RRCalCell ()
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation RRCalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCalDayModel:(WQCalendarDay *)calDayModel{
    _calDayModel = calDayModel;
    
    
    self.todayLabel.hidden = !calDayModel.isToday;
    self.dateLabel.text = @(calDayModel.day).stringValue;
    self.dateLabel.textColor = calDayModel.isCurrentMonth?[UIColor blackColor]:[UIColor grayColor];
    
}

@end
