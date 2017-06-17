//
//  AssetModel.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "AssetModel.h"
#import "PhotoManager.h"

@implementation AssetModel

@synthesize thumbnail = _thumbnail;
@synthesize previewImage = _previewImage;

#pragma mark - init

- (instancetype)initWithAsset:(PHAsset *)asset
{
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}

#pragma mark - getter&setter

- (UIImage *)thumbnail{
    if (!_thumbnail) {
        __block UIImage *tempImage;
        
        if (_asset) {
            [[PhotoManager shareInstance] getThumbnail:_asset completed:^(UIImage *image) {
                tempImage = image;
            }];
        }else{
            tempImage = [UIImage imageNamed:@"blank"];
        }
        
        _thumbnail = tempImage;
    }
    return _thumbnail;
}

- (UIImage *)previewImage{
    if (!_previewImage) {
        __block UIImage *tempImage;
        
        if (_asset) {
            [[PhotoManager shareInstance] getPreviewImage:_asset completed:^(UIImage *image) {
                tempImage = image;
            }];
        }else{
            tempImage = [UIImage imageNamed:@"blank"];
        }
        
        _previewImage = tempImage;
    }
    return _previewImage;
}

@end
