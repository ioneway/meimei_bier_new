//
//  BeautySlider.h
//
//  Created by ly on 2016/12/6.
//  Copyright © 2016年 liuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FilterSliderType) {
    FilterSliderTypeFilter           = 1,// 滤镜
    FilterSliderTypeWhite            = 2,// 美白
    FilterSliderTypeRed              = 3,// 红润
    FilterSliderTypeEyeLighting      = 4,// 亮眼
    FilterSliderTypeBeautyTooth      = 5,// 美牙
    FilterSliderTypeBlur             = 6,// 磨皮
    
    FilterSliderTypeEyeLarge              = 8,// 大眼
    FilterSliderTypeThinFace              = 9,// 瘦脸
    FilterSliderTypeJew                   = 10,// 下巴
    FilterSliderTypeForehead              = 11,// 额头
    FilterSliderTypeNose                  = 12,// 鼻子
    FilterSliderTypeMouth                 = 13,// 嘴型
    FilterSliderTypeEyeLarge_new          = 14,// 大眼
    FilterSliderTypeThinFace_new          = 15,// 瘦脸
};

@interface BeautySlider : UISlider

@property (nonatomic, assign) FilterSliderType type ;
@end
