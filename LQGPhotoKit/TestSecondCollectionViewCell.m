//
//  TestSecondCollectionViewCell.m
//  LQGPhotoKit
//
//  Created by quangang on 2017/4/26.
//  Copyright © 2017年 liquangang. All rights reserved.
//

#import "TestSecondCollectionViewCell.h"

@implementation TestSecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.testLabel];
    }
    return self;
}

#pragma mark - getter

- (UILabel *)testLabel{
    if (!_testLabel) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.textColor = [UIColor blackColor];
        tempLabel.layer.masksToBounds = YES;
        tempLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        _testLabel = tempLabel;
    }
    return _testLabel;
}

@end
