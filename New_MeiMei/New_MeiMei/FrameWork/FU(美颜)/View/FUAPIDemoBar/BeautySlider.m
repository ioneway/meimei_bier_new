//
//  BeautySlider.m
//
//  Created by ly on 2016/12/6.
//  Copyright © 2016年 liuyang. All rights reserved.
//

#import "BeautySlider.h"
#import "UIImage+demobar.h"

@implementation BeautySlider
{
    UILabel *tipLabel;
    UIImageView *bgImgView;
    
    UIView *middleView ;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setThumbImage:[UIImage imageWithName:@"expource_slider_dot"] forState:UIControlStateNormal];
    
    UIImage *bgImage = [UIImage imageWithName:@"slider_tip_white_bg"];
    bgImgView = [[UIImageView alloc] initWithImage:bgImage];
    bgImgView.frame = CGRectMake(0, -bgImage.size.height, bgImage.size.width, bgImage.size.height);
    [self addSubview:bgImgView];
    
    tipLabel = [[UILabel alloc] initWithFrame:bgImgView.frame];
    tipLabel.text = @"";
    tipLabel.textColor = [UIColor darkGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:tipLabel];
    
    bgImgView.hidden = YES;
    tipLabel.hidden = YES;
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (!middleView) {
        middleView = [[UIView alloc] initWithFrame:CGRectMake(2, self.frame.size.height /2.0 - 8, 0, 2)];
//        middleView = [[UIView alloc] init];
        middleView.backgroundColor = [UIColor colorWithRed:92/255.0 green:181/255.0 blue:249/255.0 alpha:1.0];
        [self addSubview:middleView];
        
        [self insertSubview:middleView atIndex: self.subviews.count - 2];
    }
}

// 先设置 type
-(void)setType:(FilterSliderType)type {
    _type = type ;
    switch (type) {
        case FilterSliderTypeJew:
        case FilterSliderTypeForehead:
        case FilterSliderTypeMouth:{
            [self setMaximumValue:0.5];
            [self setMinimumValue:-0.5];
            
            middleView.hidden = NO ;
            CGRect frame = middleView.frame ;
            frame.size.width = 0 ;
            middleView.frame = frame ;
            
            [self setMinimumTrackTintColor:[UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1.0]];
        }
            break;
            
        default:{
            [self setMaximumValue:1.0];
            [self setMinimumValue:0.0];
            middleView.hidden = YES ;
            [self setMinimumTrackTintColor:[UIColor colorWithRed: 92/255.0 green:181/255.0 blue:249/255.0 alpha:1.0]];
        }
            break;
    }
}

// 后设置 value
- (void)setValue:(float)value animated:(BOOL)animated   {
    [super setValue:value animated:animated];
    
    tipLabel.text = [NSString stringWithFormat:@"%d",(int)(value * 100)];
    
    BOOL isMax100 ;
    
    if (self.type == FilterSliderTypeJew || self.type == FilterSliderTypeForehead || self.type == FilterSliderTypeMouth) {
        isMax100 = NO ;
        
        CGFloat currentValue = value > 0 ? value * 100 : -value * 100 ;
        CGFloat width = currentValue / 100.0 * (self.frame.size.width - 4);
        
        if (width > 0) {
            CGFloat X = value > 0 ? self.frame.size.width / 2.0 : self.frame.size.width / 2.0 - width ;
            
            CGRect frame = middleView.frame ;
            frame = CGRectMake(X, frame.origin.y, width, frame.size.height) ;
            middleView.frame = frame ;
        }
        
    }else {
        
        isMax100 = YES ;
    }
    
    CGFloat x = isMax100 ? value * (self.frame.size.width - 20) - tipLabel.frame.size.width * 0.5 + 10 : (value + 0.5) * (self.frame.size.width - 20) - tipLabel.frame.size.width * 0.5 + 10;
    CGRect frame = tipLabel.frame;
    frame.origin.x = x;
    
    bgImgView.frame = frame;
    tipLabel.frame = frame;
    
    tipLabel.hidden = !self.tracking;
    bgImgView.hidden = !self.tracking;
}

@end
