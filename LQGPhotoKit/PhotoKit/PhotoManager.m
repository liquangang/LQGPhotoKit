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
            
            switch (assetCollection.assetCollectionSubtype) {
                case PHAssetCollectionSubtypeSmartAlbumAllHidden:
                    
                    break;
                    
                case PHAssetCollectionSubtypeSmartAlbumUserLibrary: {
                    
                    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
                    AlbumModel *tempModel = [[AlbumModel alloc] initWithFetchResult:fetchResult title:collection.localizedTitle];
                    [tempMuArray addObject:tempModel];
                    
                }
                    break;
                default: {
                    
                    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:self.options];
                    AlbumModel *tempModel = [[AlbumModel alloc] initWithFetchResult:fetchResult title:collection.localizedTitle];
                    [tempMuArray addObject:tempModel];
                    
                }
                    break;
            }
        }
    }
    
    return [tempMuArray copy];
}

/**
 *  获取每个资源对应的缩略图
 */
- (void)getThumbnail:(PHAsset *)asset completed:(void(^)(UIImage *image))completed{
    
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(THUMBNAILWIdth, THUMBNAILWIdth) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (completed) {
            completed(result);
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
