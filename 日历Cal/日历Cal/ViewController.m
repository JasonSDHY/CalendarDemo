//
//  ViewController.m
//  日历Cal
//
//  Created by Jason Ding on 16/8/15.
//  Copyright © 2016年 Ding RedRain. All rights reserved.
//

#import "ViewController.h"
#import "RRCalCell.h"
#import "RRCalLogic.h"


#define kScreenHeight  ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth   ([[UIScreen mainScreen] bounds].size.width)

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (nonatomic, strong) RRCalLogic *RRlogic;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
static NSString *cellID = @"cellID";

@implementation ViewController

#pragma mark -  Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.00];
    // 先转换成NSNumber -> integerValue 再取余
//    CGFloat offset = @(kScreenWidth).integerValue % 7;
//    CGFloat collectionWidth = kScreenWidth - offset;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreenWidth/7), (40));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 127, kScreenWidth, 240) collectionViewLayout:layout];
    collectionView.scrollEnabled = NO;
    
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"RRCalCell" bundle:nil]
     forCellWithReuseIdentifier:cellID];

    
    
    // ************
    UIImageView *hint = [[UIImageView alloc]initWithFrame:CGRectMake(20,  20 +127+240, 110, 76)];
    [hint setImage:[UIImage imageNamed:@"hintRightWrong"]];
    [self.view addSubview:hint];
}
#pragma mark -  UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RRCalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.selectedDate = self.RRlogic.selectedDate;
    cell.cellModel = self.dataArray[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6 * 7;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WQCalendarDay *dayModel = self.RRlogic.calendarDays[indexPath.item];
    // NSLog(@"%ld-%ld\n %@",dayModel.month,dayModel.day,dayModel.date);
    if ([self.RRlogic.currentDate isFutureDayWithDate:dayModel.date]) {
        [[[UIAlertView alloc]initWithTitle:@"日期超过了哟" message:nil delegate:nil cancelButtonTitle:@"朕知道了" otherButtonTitles:nil] show];
        
        return;
    }
    
    
}
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Notification Motheds
#pragma mark -  Button Callbacks
- (IBAction)upMonth:(id)sender {
    [self.RRlogic goToPreviousMonth];
    [self reloadMonthLabel];

    [self.collectionView reloadData];
}
- (IBAction)downMonth:(id)sender {
    
    [self.RRlogic goToNextMonth];
    [self reloadMonthLabel];

    [self.collectionView reloadData];
}
- (IBAction)returnCurrentMonth:(id)sender {
    [self.RRlogic loadCurrentDate];
    [self reloadMonthLabel];

    [self.collectionView reloadData];
}

#pragma mark -  Private Methods

- (void)reloadMonthLabel{
    self.monthLabel.text = [NSString stringWithFormat:@"%lu-%lu", (unsigned long)self.RRlogic.selectedCalendarDay.year, (unsigned long)self.RRlogic.selectedCalendarDay.month];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:self.RRlogic.calendarDays.count];
    for (WQCalendarDay* dayModel in self.RRlogic.calendarDays) {
        RRCalCellModel *cellModel = [[RRCalCellModel alloc]init];
        cellModel.dayModel = dayModel;
        
        // 在这里根据日期判断, 当前日期的做题情况
        cellModel.dayState = KJCurrentDayPracticeStateUnDo;
        
        [mArray addObject:cellModel];
    }
    self.dataArray = mArray;
    
}
#pragma mark -  Public Methods
#pragma mark -  Getters and Getters

- (RRCalLogic *)RRlogic{
    if (!_RRlogic) {
        _RRlogic = [[RRCalLogic alloc]init];
        [self reloadMonthLabel];
    }
    return _RRlogic;
}

@end
