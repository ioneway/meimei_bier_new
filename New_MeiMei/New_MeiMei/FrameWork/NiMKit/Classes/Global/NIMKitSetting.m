//
//  NIMKitSetting.m
//  NIMKit
//
//  Created by chris on 2017/10/30.
//  Copyright © 2017年 NetEase. All rights reserved.
//

#import "NIMKitSetting.h"
#import "UIImage+NIMKit.h"

@implementation NIMKitSetting

- (instancetype)init:(BOOL)isRight
{
    self = [super init];
    if (self)
    {
        if (isRight)
        {
            _normalBackgroundImage    =  [[UIImage nim_imageInKit:@"icon_message_textback_right"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
            _highLightBackgroundImage =  [[UIImage nim_imageInKit:@"icon_message_textback_right"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
            
        }
        else
        {
            _normalBackgroundImage    =  [[UIImage nim_imageInKit:@"icon_message_textback_left"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
            _highLightBackgroundImage =  [[UIImage nim_imageInKit:@"icon_message_textback_left"] resizableImageWithCapInsets:UIEdgeInsetsFromString(@"{18,25,17,25}") resizingMode:UIImageResizingModeStretch];
        }
        
        _font = [UIFont systemFontOfSize:14];
        _textColor = [UIColor blackColor];
    
    }
    return self;
}

@end

