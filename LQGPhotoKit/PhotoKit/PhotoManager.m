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

#define THUMBNAILSIZE CGSizeMake(SCREENSCALE * THUMBNAILWIdth, SCREENSCALE * THUMBNAILWIdth)       //缩略图size
#define PREVIEWSIZE  CGSizeMake(SCREENSCALE * SCREEN_WIDTH, SCREENSCALE * SCREEN_WIDTH)            //预览图size
#define ORIGINALSIZE PHImageManagerMaximumSize                                                     //原图size

@interface PhotoManager()

@property (nonatomic, strong) PHFetchOptions *options;
@property (nonatomic, strong) PHCachingImageManager *imageManager;

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
    
    [self getImage:THUMBNAILSIZE asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completed) {
            completed(result);
        }
    }];
}

/**
 *  获取预览图
 */
- (void)getPreviewImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
    [self getImage:PREVIEWSIZE asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completed) {
            completed(result);
        }
    }];
}

/**
 *  获取原图
 */
- (void)getOriginalImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
    [self getImage:ORIGINALSIZE asset:asset completed:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completed) {
            completed(result);
        }
    }];
}

/**
 *  获取playItem
 */
- (void)getPlayItem:(PHAsset *)asset completionHandler:(void(^)(AVPlayerItem *playerItem))completionHandler{
    [self.imageManager requestPlayerItemForVideo:asset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(playerItem);
        }
    }];
}

/**
 *  获取livePhoto
 */
- (void)getLivePhoto:(PHAsset *)asset completionHandler:(void(^)(PHLivePhoto *livePhoto))completionHandler{
    [self.imageManager requestLivePhotoForAsset:asset targetSize:PREVIEWSIZE contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
        if (completionHandler) {
            completionHandler(livePhoto);
        }
    }];
}

#pragma mark - privateMethod

/**
 *  根据不同尺寸获取图片
 */
- (void)getImage:(CGSize)size asset:(PHAsset *)asset completed:(void(^)(UIImage * _Nullable result, NSDictionary * _Nullable info))completed{
    [self.imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
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

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;
}

@end
