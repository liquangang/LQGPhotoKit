//
//  UIViewController+AuthorityManager.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "UIViewController+AuthorityManager.h"
#import "UIApplication+AuthorityManager.h"
#import "PhotoKitHeader.h"

@implementation UIViewController (AuthorityManager)

- (void)getPhotoAuthority:(void(^)(BOOL isCanUse))completed{
    
    WEAKSELF
    
    [[UIApplication sharedApplication] getPhotoAuthority:^(PHAuthorizationStatus photoAuthorizationStatus) {
        
        if (photoAuthorizationStatus == PHAuthorizationStatusRestricted ||
            photoAuthorizationStatus == PHAuthorizationStatusDenied) {
            
            UIAlertController *tempAC = [UIAlertController alertControllerWithTitle:@"" message:@"无法访问相册，请在【设置】-【隐私】-【相册】中打开权限" preferredStyle:UIAlertControllerStyleAlert];
            [tempAC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [weakSelf presentViewController:tempAC animated:YES completion:nil];
            
            if (completed) {
                completed(NO);
            }
        
        }
        
        if (completed) {
            completed(YES);
        }
    }];
}

@end
