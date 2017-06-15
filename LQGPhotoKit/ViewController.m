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
#import "PhotoKitHeader.h"
#import "ControlHeaderView.h"
#import "PhotoHomeViewController.h"

static NSString *itemResuableStr = @"UICollectionViewCell";
static NSString *headerResuableStr = @"UICollectionReusableView";

@interface ViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *selectImageCollectionView;
@property (nonatomic, strong) LQGWaterFlowLayout *waterLayout;
@property (nonatomic, strong) NSMutableArray *dataSourceMuArray;
@property (nonatomic, strong) ControlHeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.selectImageCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceMuArray.count == 0 ? 4 : self.dataSourceMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemResuableStr forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage new]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    cell.layer.borderWidth = 0.5;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        [header addSubview:self.headerView];
        
        [self.headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        footer.backgroundColor = [UIColor greenColor];
        return footer;
    }
}

#pragma mark - private method

- (void)photoButtonAction:(UIButton *)btn{
    [PhotoHomeViewController presentSelectPhoto:self];
}

#pragma mark - getter

- (UICollectionView *)selectImageCollectionView{
    if (!_selectImageCollectionView) {
        UICollectionView *tempCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.backgroundColor = [UIColor clearColor];
        [tempCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemResuableStr];
        [tempCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [tempCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerResuableStr];
        
        _selectImageCollectionView = tempCollectionView;
    }
    return _selectImageCollectionView;
}

- (LQGWaterFlowLayout *)waterLayout{
    if (!_waterLayout) {
        LQGWaterFlowLayout *tempWaterLayout = [[LQGWaterFlowLayout alloc] initWithColumnsCount:4 rowMargin:0 columnsMargin:0 sectionEdgeInset:UIEdgeInsetsMake(0, 0, 0, 0) getItemSize:^CGFloat(NSIndexPath *itemIndex) {
            return SCREEN_WIDTH / 4;
        } getHeaderSize:^CGSize(NSIndexPath *headerIndex) {
            return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), SCREEN_WIDTH / 4);
        } getFooterSize:^CGSize(NSIndexPath *footerIndex) {
            return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0);
        }];
        _waterLayout = tempWaterLayout;
    }
    return _waterLayout;
}

- (NSMutableArray *)dataSourceMuArray{
    if (!_dataSourceMuArray) {
        NSMutableArray *tempMuArray = [NSMutableArray new];
       
        _dataSourceMuArray = tempMuArray;
    }
    return _dataSourceMuArray;
}

- (ControlHeaderView *)headerView{
    if (!_headerView) {
        ControlHeaderView *tempView = [[ControlHeaderView alloc] init];
        [tempView.photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _headerView = tempView;
    }
    return _headerView;
}

@end
