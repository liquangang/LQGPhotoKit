//
//  ViewController.m
//  LQGPhotoKit
//
//  Created by liquangang on 2017/4/16.
//  Copyright © 2017年 liquangang. All rights reserved.
//

/**************************************
 保存已选中的部分、缩略图等信息
 **************************************/

#import "ViewController.h"
#import "LQGWaterFlowLayout.h"
#import <MJRefresh.h>
#import "TestSecondCollectionViewCell.h"

static NSString *itemResuableStr = @"TestSecondCollectionViewCell";
static NSString *headerResuableStr = @"UICollectionReusableView";
static NSInteger loadCount = 36;

@interface ViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *selectImageCollectionView;
@property (nonatomic, strong) LQGWaterFlowLayout *waterLayout;
@property (nonatomic, assign) NSUInteger sectionCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sectionCount = loadCount;
    [self.view addSubview:self.selectImageCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sectionCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TestSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemResuableStr forIndexPath:indexPath];
    cell.testLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.item)];
    cell.testLabel.frame = cell.contentView.frame;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        header.backgroundColor = [UIColor redColor];
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        footer.backgroundColor = [UIColor redColor];
        return footer;
    }
}

#pragma mark - private method

/**
 *  随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % ((to) - (from) + 1)));
}

#pragma mark - getter

- (UICollectionView *)selectImageCollectionView{
    if (!_selectImageCollectionView) {
        UICollectionView *tempCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.backgroundColor = [UIColor grayColor];
        [tempCollectionView registerClass:[TestSecondCollectionViewCell class] forCellWithReuseIdentifier:itemResuableStr];
        [tempCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [tempCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerResuableStr];
       
        __weak typeof(self) weakSelf = self;
        tempCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.sectionCount += loadCount;
                [tempCollectionView.mj_footer endRefreshing];
                [tempCollectionView reloadData];
            });
        }];
        
        _selectImageCollectionView = tempCollectionView;
    }
    return _selectImageCollectionView;
}

- (LQGWaterFlowLayout *)waterLayout{
    if (!_waterLayout) {
        LQGWaterFlowLayout *tempWaterLayout = [[LQGWaterFlowLayout alloc] initWithColumnsCount:4 rowMargin:0 columnsMargin:0 sectionEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0) getItemSize:^CGFloat(NSIndexPath *itemIndex) {
            return 100;
        } getHeaderSize:^CGSize(NSIndexPath *headerIndex) {
            return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 100);
        } getFooterSize:^CGSize(NSIndexPath *footerIndex) {
            return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 100);
        }];
        _waterLayout = tempWaterLayout;
    }
    return _waterLayout;
}

- (UICollectionViewFlowLayout *)osLayout{
    UICollectionViewFlowLayout *tempFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    tempFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.width / 3);
    tempFlowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    tempFlowLayout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    return tempFlowLayout;
}

@end
