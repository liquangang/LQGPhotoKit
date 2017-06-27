//
//  PhotoCollectionViewCell.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/16.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - getter & setter

- (void)setAssetModel:(AssetModel *)assetModel{
    _assetModel = assetModel;
    
    [assetModel getThumbnailCompletionHandler:^(UIImage *image) {
        _imageView.image = image;
    }];
    
    if (assetModel.type != Video) {
        _playImage.hidden = YES;
    }else{
        _playImage.hidden = NO;
    }
    
    if (assetModel.asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        _livePhotoLabel.hidden = NO;
    }else{
        _livePhotoLabel.hidden = YES;
    }
}

@end
