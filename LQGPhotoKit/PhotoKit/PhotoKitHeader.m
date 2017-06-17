//
//  PhotoKitHeader.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "PhotoKitHeader.h"

@implementation PhotoKitHeader

/**
 *  主线程
 */
+ (void)asyncMainQueue:(void(^)())mainQueueBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        mainQueueBlock();
    });
}

/**
 *  后台异步多线程
 */
+ (void)asyncBackgroundQueue:(void(^)())backgroundQueueBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        backgroundQueueBlock();
    });
}

@end
