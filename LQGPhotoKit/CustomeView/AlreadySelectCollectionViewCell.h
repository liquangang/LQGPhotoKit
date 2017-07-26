//
//  AlreadySelectCollectionViewCell.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/7/26.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetModel.h"

@interface AlreadySelectCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) AssetModel *assetModel;

@end
