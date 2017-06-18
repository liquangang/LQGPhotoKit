//
//  AssetModel.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface AssetModel : NSObject

@property (nonatomic, strong) PHAsset *asset;           //对应的资源对象

@property (nonatomic, strong) UIImage *thumbnail;       //对应的缩略图

@property (nonatomic, strong) UIImage *previewImage;    //预览图

@property (nonatomic, strong) UIImage *originalImage;   //原图

- (instancetype)initWithAsset:(PHAsset *)asset;

@end
