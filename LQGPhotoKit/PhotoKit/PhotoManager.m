//
//  PhotoManager.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "PhotoManager.h"
#import "PhotoKitHeader.h"
#import "AlbumModel.h"

@interface PhotoManager()

@property (nonatomic, strong) PHFetchOptions *options;
@property (nonatomic, strong) PHImageRequestOptions *originRequestOptions;

@end

@implementation PhotoManager

#pragma mark - init

CREATESINGLETON(PhotoManager)

#pragma mark - publicMethod

/**
 *  获取相册资源数组
 */
- (NSArray *)getAlbums{
    
    NSMutableArray *tempMuArray = [NSMutableArray new];
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHCollection *collection in smartAlbums) {
        
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
            AlbumModel *tempModel = [[AlbumModel alloc] initWithFetchResult:fetchResult title:collection.localizedTitle];
            [tempMuArray addObject:tempModel];
            
        }
    }
    
    return [tempMuArray copy];
}

/**
 *  获取每个资源对应的缩略图
 */
- (void)getThumbnail:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
    [self getImage:CGSizeMake(SCREENSCALE * THUMBNAILWIdth, SCREENSCALE * THUMBNAILWIdth) asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completed) {
            completed(result);
        }
    }];
}

/**
 *  获取预览图
 */
- (void)getPreviewImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
//    WEAKSELF
//    self.originRequestOptions.synchronous = YES;
//    self.originRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    [self getImage:CGSizeMake(SCREENSCALE * SCREEN_WIDTH, SCREENSCALE * SCREEN_WIDTH) asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        weakSelf.originRequestOptions.synchronous = NO;
//        weakSelf.originRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        if (completed) {
            completed(result);
        }
    }];
}

/**
 *  获取原图
 */
- (void)getOriginImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
    [self getImage:PHImageManagerMaximumSize asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completed) {
            completed(result);
        }
    }];
}

#pragma mark - privateMethod

/**
 *  根据不同尺寸获取图片
 */
- (void)getImage:(CGSize)size asset:(PHAsset *)asset completed:(void(^)(UIImage * _Nullable result, NSDictionary * _Nullable info))completed{
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:self.originRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (completed) {
            completed(result, info);
        }
    }];
}

#pragma mark - getter

- (PHFetchOptions *)options {
    if (!_options) {
        _options = [[PHFetchOptions alloc] init];
        _options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    }
    return _options;
}

- (PHImageRequestOptions *)originRequestOptions{
    if (!_originRequestOptions) {
        PHImageRequestOptions *originRequestOptions = [[PHImageRequestOptions alloc] init];
        originRequestOptions.synchronous = YES;
        originRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        
        _originRequestOptions = originRequestOptions;
    }
    return _originRequestOptions;
}

@end
