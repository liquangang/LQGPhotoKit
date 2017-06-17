//
//  PhotoPreviewViewController.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/16.
//  Copyright © 2017年 liquangang. All rights reserved.
//

//图片全屏预览界面

#import "PhotoPreviewViewController.h"
#import "AssetModel.h"
#import "PhotoPreviewCollectionViewCell.h"

static NSString *itemResuableID = @"PhotoPreviewCollectionViewCell";

@interface PhotoPreviewViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PhotoPreviewViewController

- (void)dealloc{
    NSLog(@"%@ dealloc", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked:)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemResuableID forIndexPath:indexPath];
    cell.assetModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - publicMethod

+ (void)pushToPreviewVc:(UINavigationController *)nav dataSource:(NSMutableArray *)dataSource indexPath:(NSIndexPath *)indexPath{
    
    if (dataSource.count > 0) {
        PhotoPreviewViewController *tempVc = [PhotoPreviewViewController new];
        tempVc.dataSource = dataSource;
        tempVc.indexPath = indexPath;
        
        [nav pushViewController:tempVc animated:YES];
    }
}

#pragma mark - privateMethod

- (void)rightBarButtonClicked:(UIBarButtonItem *)barButtonItem{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter & setter

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *tempLayout = [[UICollectionViewFlowLayout alloc] init];
        tempLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        tempLayout.itemSize = self.view.bounds.size;
        tempLayout.minimumLineSpacing = 0;
        tempLayout.minimumInteritemSpacing = 0;
        tempLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        UICollectionView *tempView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:tempLayout];
        tempView.backgroundColor = [UIColor clearColor];
        tempView.pagingEnabled = YES;
        tempView.dataSource = self;
        tempView.delegate = self;
        [tempView registerNib:[UINib nibWithNibName:itemResuableID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:itemResuableID];
        
        _collectionView = tempView;
    }
    return _collectionView;
}

@end
