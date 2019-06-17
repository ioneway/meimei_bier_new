//
//  UIImage+demobar.m
//  FUAPIDemoBar
//
//  Created by 刘洋 on 2017/2/16.
//  Copyright © 2017年 刘洋. All rights reserved.
//

#import "UIImage+demobar.h"
#import "FUDemoBar.h"

@implementation UIImage (demobar)

+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

@end
