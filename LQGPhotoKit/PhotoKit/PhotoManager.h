//
//  PhotoManager.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface PhotoManager : NSObject

/**
 *  获取该类的对象的单例
 */
+ (instancetype)shareInstance;

/**
 *  获取相册资源数组
 */
- (NSArray *)getAlbums;

/**
 *  获取每个资源对应的缩略图（用于item上显示）
 */
- (void)getThumbnail:(PHAsset *)asset completed:(void(^)(UIImage *image))completed;

/**
 *  获取预览图（用于全屏显示的预览图）
 */
- (void)getPreviewImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed;

/**
 *  获取原图
 */
- (void)getOriginImage:(PHAsset *)asset completed:(void(^)(UIImage *image))completed;

@end
