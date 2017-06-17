//
//  PhotoPreviewCollectionViewCell.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/16.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetModel.h"

@interface PhotoPreviewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) AssetModel *assetModel;

@end
