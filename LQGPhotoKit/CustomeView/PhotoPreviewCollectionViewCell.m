//
//  PhotoPreviewCollectionViewCell.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/16.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "PhotoPreviewCollectionViewCell.h"

@implementation PhotoPreviewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - getter & setter

- (void)setAssetModel:(AssetModel *)assetModel{
    _assetModel = assetModel;
    
    _imageView.image = assetModel.thumbnail;
}



@end
