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

@end
static NSString *cellID = @"cellID";

@implementation ViewController

#pragma mark -  Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreenWidth/7), (40));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 400) collectionViewLayout:layout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:@"RRCalCell" bundle:nil]
     forCellWithReuseIdentifier:cellID];
}
#pragma mark -  UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RRCalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.calDayModel = self.RRlogic.calendarDays[indexPath.item];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6 * 7;
}
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Notification Motheds
#pragma mark -  Button Callbacks
- (IBAction)upMonth:(id)sender {
    [self.RRlogic goToPreviousMonth];
    [self.collectionView reloadData];
    [self reloadMonthLabel];
}
- (IBAction)downMonth:(id)sender {
    
    [self.RRlogic goToNextMonth];
    [self.collectionView reloadData];
    [self reloadMonthLabel];
}
- (IBAction)returnCurrentMonth:(id)sender {
    [self.RRlogic loadCurrentDate];
    [self.collectionView reloadData];
    [self reloadMonthLabel];
}

#pragma mark -  Private Methods

- (void)reloadMonthLabel{
    self.monthLabel.text = [NSString stringWithFormat:@"%lu年%lu月", (unsigned long)self.RRlogic.selectedCalendarDay.year, (unsigned long)self.RRlogic.selectedCalendarDay.month];
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
