//
//  NIMGiftContentConfig.m
//  PengPengApp
//
//  Created by air on 2018/12/1.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

#import "NIMGiftContentConfig.h"
#import "UIImage+NIMKit.h"
#import "NIMKit.h"
#import "GiftAttachment.h"

@implementation NIMGiftContentConfig

- (CGSize)contentSize:(CGFloat)cellWidth message:(NIMMessage *)message
{
    
    return CGSizeMake(100, 90);
}

- (NSString *)cellContent:(NIMMessage *)message
{
    return @"NIMSessionGiftContentView";
}

- (UIEdgeInsets)contentViewInsets:(NIMMessage *)message
{
    return [[NIMKit sharedKit].config setting:message].contentInsets;
}

@end
