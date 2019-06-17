//
//  FUOpenGLView.h
//  FULiveDemo
//
//  Created by 刘洋 on 2017/8/15.
//  Copyright © 2017年 刘洋. All rights reserved.
//

#import <GLKit/GLKit.h>

typedef NS_ENUM(NSInteger, FUOpenGLViewOrientation) {
    FUOpenGLViewOrientationPortrait              = 0,
    FUOpenGLViewOrientationPortraitUpsideDown    = 1,
    FUOpenGLViewOrientationLandscapeRight        = 2,
    FUOpenGLViewOrientationLandscapeLeft         = 3,
};

@interface FUOpenGLView : UIView

// 设置视频朝向，保证视频总是竖屏播放
@property (nonatomic, assign) FUOpenGLViewOrientation origintation ;

- (void)displayPixelBuffer:(CVPixelBufferRef)pixelBuffer;

- (void)displayPixelBuffer:(CVPixelBufferRef)pixelBuffer withLandmarks:(float *)landmarks count:(int)count;

@end
