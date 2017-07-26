//
//  AlreadySelectCollectionViewCell.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/7/26.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "AlreadySelectCollectionViewCell.h"
#import "PhotoManager.h"

@implementation AlreadySelectCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAssetModel:(AssetModel *)assetModel{
    WEAKSELF
    _assetModel = assetModel;
    
    [assetModel getThumbnailCompletionHandler:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
}

@end
