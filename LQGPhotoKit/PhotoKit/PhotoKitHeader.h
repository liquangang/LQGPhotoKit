//
//  PhotoKitHeader.h
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry.h>

#define WEAKSELF __weak __typeof(&*self)weakSelf = self;        //弱引用宏

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height  //屏幕高度

#define THUMBNAILWIdth (SCREEN_WIDTH / 4)                       //缩略图默认宽度（由于是正方形，也是默认高度）

#define SCREENSCALE [UIScreen mainScreen].scale                 //屏幕缩放比例

#define ColorFromRGB(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(alphaValue)];      //颜色设置

/**
 *  创建单例
 */
#define CREATESINGLETON(singletonClassName) \
static singletonClassName *instance;\
+ (instancetype)shareInstance{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[singletonClassName alloc] init] ;\
}) ;\
return instance;\
}\
+ (id)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [super allocWithZone:zone] ;\
}) ;\
return instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return instance;\
}

@interface PhotoKitHeader : NSObject

/**
 *  主线程
 */
+ (void)asyncMainQueue:(void(^)())mainQueueBlock;

/**
 *  后台异步多线程
 */
+ (void)asyncBackgroundQueue:(void(^)())backgroundQueueBlock;

@end
