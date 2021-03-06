//
//  FUManager.h
//  FULiveDemo
//
//  Created by 刘洋 on 2017/8/18.
//  Copyright © 2017年 刘洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class FULiveModel ;
@interface FUManager : NSObject

@property (nonatomic, assign)               BOOL enableGesture;         /**设置是否开启手势识别，默认未开启*/
@property (nonatomic, assign)               BOOL enableMaxFaces;        /**设置人脸识别个数，默认为单人模式*/

@property (nonatomic, assign) BOOL skinDetectEnable ;   // 精准美肤
@property (nonatomic, assign) NSInteger blurShape;      // 美肤类型 (0、1、) 清晰：0，朦胧：1
@property (nonatomic, assign) double blurLevel;         // 磨皮(0.0 - 6.0)
@property (nonatomic, assign) double whiteLevel;        // 美白
@property (nonatomic, assign) double redLevel;          // 红润
@property (nonatomic, assign) double eyelightingLevel;  // 亮眼
@property (nonatomic, assign) double beautyToothLevel;  // 美牙

@property (nonatomic, assign) NSInteger faceShape;        //脸型 (0、1、2、3、4)女神：0，网红：1，自然：2，默认：3，自定义：4
@property (nonatomic, assign) double enlargingLevel;      /**大眼 (0~1)*/
@property (nonatomic, assign) double thinningLevel;       /**瘦脸 (0~1)*/
@property (nonatomic, assign) double enlargingLevel_new;  /**大眼 (0~1) --  新版美颜*/
@property (nonatomic, assign) double thinningLevel_new;   /**瘦脸 (0~1) --  新版美颜*/

@property (nonatomic, assign) double jewLevel;            /**下巴 (0~1)*/
@property (nonatomic, assign) double foreheadLevel;       /**额头 (0~1)*/
@property (nonatomic, assign) double noseLevel;           /**鼻子 (0~1)*/
@property (nonatomic, assign) double mouthLevel;          /**嘴型 (0~1)*/

@property (nonatomic, strong) NSArray<NSString *> *filtersDataSource;     /**滤镜名称数组*/
@property (nonatomic, strong) NSArray<NSString *> *beautyFiltersDataSource;     /**美颜滤镜名称数组*/
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *filtersCHName;       /**滤镜中文名称数组*/
@property (nonatomic, strong) NSString *selectedFilter; /* 选中的滤镜 */
@property (nonatomic, assign) double selectedFilterLevel; /* 选中滤镜的 level*/

@property (nonatomic, strong)               NSMutableArray<FULiveModel *> *dataSource;  /**道具分类数组*/
@property (nonatomic, strong)               NSString *selectedItem;     /**选中的道具名称*/

/****  美妆程度  ****/
@property (nonatomic, assign) double lipstick;          // 口红
@property (nonatomic, assign) double blush;             // 腮红
@property (nonatomic, assign) double eyebrow;           // 眉毛
@property (nonatomic, assign) double eyeShadow;         // 眼影
@property (nonatomic, assign) double eyeLiner;          // 眼线
@property (nonatomic, assign) double eyelash;           // 睫毛
@property (nonatomic, assign) double contactLens;       // 美瞳

// 是否性能优先
@property (nonatomic, assign) BOOL performance ;
// 当前页面的 model
@property (nonatomic, strong) FULiveModel *currentModel ;

+ (FUManager *)shareManager;

- (void)setAsyncTrackFaceEnable:(BOOL)enable;

// 默认美颜参数
- (void)setBeautyDefaultParameters ;
/**初始化Faceunity,加载道具*/
- (void)loadItems;

/**加载美颜道具*/
- (void)loadFilter ;
//
///**加载美妆道具*/
//- (void)loadMakeupItem ;

/**销毁全部道具*/
- (void)destoryItems;
/* 销毁指定道具
 */
- (void)destoryItem:(int)index;

/**加载普通道具*/
- (void)loadItem:(NSString *)itemName;

/* 添加动漫滤镜 */
- (void)loadFilterAnimoji:(NSString *)itemName style:(int)style;
/**
 合成海报输入参数

 @param posterImage 海报模板照片
 @param photoImage 人脸照片
 @param photoLandmarks 要处理人脸点位
 */
-(void)productionPoster:(UIImage *)posterImage photo:(UIImage *)photoImage photoLandmarks:(float *)photoLandmarks warpValue:(id)warpValue;
/* 海报合成 */
- (UIImage *)renderItemsToImage:(UIImage *)image;

/**
 美妆贴纸

 @param image 贴纸图片
 @param paramStr nama 参数
 */
-(void)loadMakeupItemImage:(UIImage *)image param:(NSString *)paramStr;
/**
 美妆程度值

 @param value 0~1
 @param paramStr nama 参数
 */
-(void)makeupIntensity:(float )value param:(NSString *)paramStr;
/**
 口红色值

 @param lipData [0,0,0,0] //长度为4的数组，rgba颜色值
 */
-(void)makeupLipstick:(double *)lipData;

- (void)setHairStrength:(float)strength;

/* 加载海报道具 */
- (void)loadPoster;
/* 销毁海报道具 */
- (void)destroyItemPoster;

- (void)loadAnimojiFaxxBundle ;

- (void)destoryAnimojiFaxxBundle ;

- (void)musicFilterSetMusicTime ;

/**设置美发参数**/
- (void)setHairColor:(int)colorIndex ;

/** 表情校准 **/
//- (void)setCalibrating ;
//- (void)removeCalibrating ;
//- (BOOL)isCalibrating ;

/**获取item的提示语*/
- (NSString *)hintForItem:(NSString *)item;

- (NSString *)alertForItem:(NSString *)item ;

/**将道具绘制到pixelBuffer*/
- (CVPixelBufferRef)renderItemsToPixelBuffer:(CVPixelBufferRef)pixelBuffer;

- (void)set3DFlipH ;

- (void)setLoc_xy_flip ;

/**获取75个人脸特征点*/
- (void)getLandmarks:(float *)landmarks index:(int)index;

/**
 获取图像中人脸中心点位置

 @param frameSize 图像的尺寸，该尺寸要与视频处理接口或人脸信息跟踪接口中传入的图像宽高相一致
 @return 返回一个以图像左上角为原点的中心点
 */
- (CGPoint)getFaceCenterInFrameSize:(CGSize)frameSize;

/**判断是否检测到人脸*/
- (BOOL)isTracking;

/**切换摄像头要调用此函数*/
- (void)onCameraChange;

/**获取错误信息*/
- (NSString *)getError;

/**判断 SDK 是否是 lite 版本**/
- (BOOL)isLiteSDK ;

/**获取设备型号**/
- (NSString *)getPlatformtype ;


@end
