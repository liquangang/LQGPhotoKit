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

@end
