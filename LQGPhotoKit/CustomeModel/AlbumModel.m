//
//  AlbumModel.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "AlbumModel.h"
#import "PhotoManager.h"
#import "PhotoKitHeader.h"

@implementation AlbumModel

@synthesize thumbnail = _thumbnail;

- (instancetype)initWithFetchResult:(PHFetchResult *)fetchResult title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.fetchResult = fetchResult;
        self.title = title;
    }
    return self;
}

#pragma mark - getter&setter

- (UIImage *)thumbnail{
    if (!_thumbnail) {
        __block UIImage *tempImage;
        
        if (_fetchResult.count > 0) {
            PHAsset *tempAsset = _fetchResult[_fetchResult.count - 1];
            [[PhotoManager shareInstance] getThumbnail:tempAsset completed:^(UIImage *image) {
                tempImage = image;
            }];
        }
        
        _thumbnail = tempImage;
    }
    return _thumbnail;
}

@end
