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

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@end

@implementation RRCalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setCellModel:(RRCalCellModel *)cellModel{
    _cellModel = cellModel;
    WQCalendarDay *calDayModel = cellModel.dayModel;
    
    self.todayLabel.hidden = !calDayModel.isToday;
    self.dateLabel.text = @(calDayModel.day).stringValue;
    self.dateLabel.textColor = [calDayModel isSameMonthWithDate:self.selectedDate]?[UIColor blackColor]:[UIColor grayColor];
    
    
    switch (cellModel.dayState) {
        case KJCurrentDayPracticeStateUnDo: {
            self.stateImageView.hidden = YES;
            break;
        }
        case KJCurrentDayPracticeStateSuccess: {
            self.stateImageView.hidden = NO;

            self.stateImageView.image = [UIImage imageNamed:@"calYesBig"];
            break;
        }
        case KJCurrentDayPracticeStateWrong: {
            self.stateImageView.hidden = NO;

            self.stateImageView.image = [UIImage imageNamed:@"calWrongBig"];
            break;
        }
    }

}

@end
