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

@property (nonatomic, strong) RRCalLogic *RRlogic;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
static NSString *cellID = @"cellID";

@implementation ViewController

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

- (IBAction)upMonth:(id)sender {
    [self.RRlogic goToPreviousMonth];
    [self.collectionView reloadData];
}
- (IBAction)downMonth:(id)sender {
    
    [self.RRlogic goToNextMonth];
    [self.collectionView reloadData];
}

- (RRCalLogic *)RRlogic{
    if (!_RRlogic) {
        _RRlogic = [[RRCalLogic alloc]init];
    }
    return _RRlogic;
}

@end
