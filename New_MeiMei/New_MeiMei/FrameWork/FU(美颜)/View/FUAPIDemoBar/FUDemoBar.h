//
//  FUDemoBar.h
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoBarType.h"



@protocol FUDemoBarDelegate <NSObject>

@optional

- (void)demoBarDidSelectedItem:(NSString *)itemName;

- (void)demoBarDidSelectedFilter:(NSString *)filter;

- (void)demoBarBeautyParamChanged;

- (void)demoBarDidShowTopView:(BOOL)shown Animation:(BOOL)animation;

- (void)demoBarDidShowTip:(NSString *)tip isShow:(BOOL)show ;

@end

@interface FUDemoBar : UIView

@property (nonatomic, assign) id<FUDemoBarDelegate> delegate;

@property (nonatomic, assign) FUAPIDemoBarType demoBarType ;

@property (nonatomic, assign) BOOL skinDetectEnable ;

@property (nonatomic, assign) NSInteger blurShape;      // 美肤类型 (0、1、) 清晰：0，朦胧：1
@property (nonatomic, assign) double blurLevel;         // 磨皮
@property (nonatomic, assign) double whiteLevel;        // 美白
@property (nonatomic, assign) double redLevel;          // 红润
@property (nonatomic, assign) double eyelightingLevel;  // 亮眼
@property (nonatomic, assign) double beautyToothLevel;  // 美牙

@property (nonatomic, assign) NSInteger faceShape;        //美型类型 (0、1、2、) 女神：0，网红：1，自然：2
@property (nonatomic, assign) double enlargingLevel;      /**大眼 (0~1)*/
@property (nonatomic, assign) double thinningLevel;       /**瘦脸 (0~1)*/
@property (nonatomic, assign) double enlargingLevel_new;      /**大眼 (0~1) --  新版美颜*/
@property (nonatomic, assign) double thinningLevel_new;       /**瘦脸 (0~1) --  新版美颜*/
@property (nonatomic, assign) double jewLevel;            /**下巴 (0~1)*/
@property (nonatomic, assign) double foreheadLevel;       /**额头 (0~1)*/
@property (nonatomic, assign) double noseLevel;           /**鼻子 (0~1)*/
@property (nonatomic, assign) double mouthLevel;          /**嘴型 (0~1)*/

@property (nonatomic, strong) NSArray<NSString *> *itemsDataSource ; /**道具名称数组*/
@property (nonatomic, copy) NSString *selectedItem ;                 /**选中的道具名称*/

@property (nonatomic, strong) NSArray<NSString *> *filtersDataSource;     /**滤镜名称数组*/
@property (nonatomic, strong) NSArray<NSString *> *beautyFiltersDataSource;     /**美颜滤镜名称数组*/
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *filtersCHName;       /**滤镜中文名称数组*/
@property (nonatomic, copy)   NSString *selectFilter ;
@property (nonatomic, assign)   double selectedFilterLevel ;

- (void)setFilterLevel:(double)level forFilter:(NSString *)filter;

@end
