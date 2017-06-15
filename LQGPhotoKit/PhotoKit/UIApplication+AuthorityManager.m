//
//  UIApplication+AuthorityManager.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/6/15.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "UIApplication+AuthorityManager.h"

@implementation UIApplication (AuthorityManager)

- (void)getPhotoAuthority:(void(^)(PHAuthorizationStatus photoAuthorizationStatus))completed{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    if (authStatus == PHAuthorizationStatusAuthorized ||
        authStatus == PHAuthorizationStatusRestricted ||
        authStatus == PHAuthorizationStatusDenied) {
        
        if (completed) {
            completed(authStatus);
        }
        
    }else if (authStatus == PHAuthorizationStatusNotDetermined){
        
        //用户未做过请求，主动请求一次
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (completed) {
                completed(status);
            }
        }];
    }
}

@end
