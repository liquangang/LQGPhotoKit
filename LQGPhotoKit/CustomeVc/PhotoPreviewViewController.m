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
@property (nonatomic, strong) AVPlayerLayer *playLayer;
@property (nonatomic, strong) AVPlayer *player;

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
    WEAKSELF
    
    AssetModel *tempModel = self.dataSource[indexPath.row];
    PhotoPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemResuableID forIndexPath:indexPath];
    cell.assetModel = tempModel;
    
    [cell setPlayButtonBlock:^{
        [[PhotoManager shareInstance] getPlayItem:tempModel.asset completionHandler:^(AVPlayerItem *playerItem) {
            [PhotoKitHeader asyncMainQueue:^{
                
                weakSelf.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
                
                weakSelf.playLayer = [AVPlayerLayer playerLayerWithPlayer:weakSelf.player];
                weakSelf.playLayer.frame = weakSelf.view.bounds;
                
                [weakSelf.view.layer addSublayer:weakSelf.playLayer];
                [weakSelf.player play];
            }];
        }];
    }];
    
    return cell;
}

/**
 *  当cell要出现的时候处理一下，因为collectionView会预加载一个未显示的cell，这会导致cell的内容未被刷新，导致ui显示错误（全屏显示会遇到）
 */
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //当下一个cell出现时移除播放器（其他时刻移除会出现播放器移除过早的情况，此时还没有切到另一个cell）
    [self.playLayer removeFromSuperlayer];
    [self.player pause];
    
    AssetModel *tempModel = self.dataSource[indexPath.row];
    PhotoPreviewCollectionViewCell *previewCell = (PhotoPreviewCollectionViewCell *)cell;
    previewCell.assetModel = tempModel;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
