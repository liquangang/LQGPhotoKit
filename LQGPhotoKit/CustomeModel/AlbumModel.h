//
//  AlbumModel.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface AlbumModel : NSObject

@property (nonatomic, strong) PHFetchResult *fetchResult;   //资源对象
@property (nonatomic, strong) NSString *title;              //相册名称
@property (nonatomic, strong, readonly) UIImage *thumbnail;           //相册缩略图

/**
 *  初始化方法
 */
- (instancetype)initWithFetchResult:(PHFetchResult *)fetchResult title:(NSString *)title;

@end
