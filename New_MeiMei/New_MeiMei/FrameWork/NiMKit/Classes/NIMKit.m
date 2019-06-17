//
//  NIMKit.m
//  NIMKit
//
//  Created by amao on 8/14/15.
//  Copyright (c) 2015 NetEase. All rights reserved.
//

#import "NIMKit.h"
#import "NIMKitTimerHolder.h"
#import "NIMKitNotificationFirer.h"
#import "NIMKitDataProviderImpl.h"
#import "NIMCellLayoutConfig.h"
#import "NIMKitInfoFetchOption.h"

extern NSString *const NIMKitUserInfoHasUpdatedNotification;
extern NSString *const NIMKitTeamInfoHasUpdatedNotification;


@interface NIMKit(){
    NSRegularExpression *_urlRegex;
}
@property (nonatomic,strong)    NIMKitNotificationFirer *firer;
@property (nonatomic,strong)    id<NIMCellLayoutConfig> layoutConfig;
@end


@implementation NIMKit
- (instancetype)init
{
    if (self = [super init]) {
        _resourceBundleName  = @"NIMKitResource.bundle";
        _emoticonBundleName  = @"NIMKitEmoticon.bundle";
        
        _firer = [[NIMKitNotificationFirer alloc] init];
        _provider = [[NIMKitDataProviderImpl alloc] init];   //默认使用 NIMKit 的实现
        
        _layoutConfig = [[NIMCellLayoutConfig alloc] init];
        _robotTemplateParser = [[NIMKitRobotDefaultTemplateParser alloc] init];
        
        [self preloadNIMKitBundleResource];
    }
    return self;
}

+ (instancetype)sharedKit
{
    static NIMKit *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NIMKit alloc] init];
    });
    return instance;
}

- (void)registerLayoutConfig:(NIMCellLayoutConfig *)layoutConfig
{
    if ([layoutConfig isKindOfClass:[NIMCellLayoutConfig class]])
    {
        self.layoutConfig = layoutConfig;
    }
    else
    {
        NSAssert(0, @"class should be subclass of NIMLayoutConfig");
    }
}


- (id<NIMCellLayoutConfig>)layoutConfig
{
    return _layoutConfig;
}

- (NIMKitConfig *)config
{
    //不要放在 NIMKit 初始化里面，因为 UIConfig 初始化会使用 NIMKit, 防止死循环
    if (!_config)
    {
        _config = [[NIMKitConfig alloc] init];
    }
    return _config;
}

- (void)notfiyUserInfoChanged:(NSArray *)userIds{
    if (!userIds.count) {
        return;
    }
    for (NSString *userId in userIds) {
        NIMSession *session = [NIMSession session:userId type:NIMSessionTypeP2P];
        NIMKitFirerInfo *info = [[NIMKitFirerInfo alloc] init];
        info.session = session;
        info.notificationName = NIMKitUserInfoHasUpdatedNotification;
        [self.firer addFireInfo:info];
    }
}

- (void)notifyTeamInfoChanged:(NSArray *)teamIds{
    if (teamIds.count)
    {
        for (NSString *teamId in teamIds)
        {
            [self notifyTeam:teamId];
        }
    }
    else
    {
        [self notifyTeam:nil];
    }
}

- (void)notifyTeamMemebersChanged:(NSArray *)teamIds
{
    if (teamIds.count)
    {
        for (NSString *teamId in teamIds)
        {
            [self notifyTeamMemebers:teamId];
        }
    }
    else
    {
        [self notifyTeamMemebers:nil];
    }
}


- (void)notifyTeam:(NSString *)teamId
{
    NIMKitFirerInfo *info = [[NIMKitFirerInfo alloc] init];
    if (teamId.length) {
        NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
        info.session = session;
    }
    info.notificationName = NIMKitTeamInfoHasUpdatedNotification;
    [self.firer addFireInfo:info];
}

- (void)notifyTeamMemebers:(NSString *)teamId
{
    NIMKitFirerInfo *info = [[NIMKitFirerInfo alloc] init];
    if (teamId.length) {
        NIMSession *session = [NIMSession session:teamId type:NIMSessionTypeTeam];
        info.session = session;
    }
    extern NSString *NIMKitTeamMembersHasUpdatedNotification;
    info.notificationName = NIMKitTeamMembersHasUpdatedNotification;
    [self.firer addFireInfo:info];
}

- (NIMKitInfo *)infoByUser:(NSString *)userId option:(NIMKitInfoFetchOption *)option
{
    NIMKitInfo *info = nil;
    if (self.provider && [self.provider respondsToSelector:@selector(infoByUser:option:)]) {
        info = [self.provider infoByUser:userId option:option];
    }
    return info;
}

- (NIMKitInfo *)infoByTeam:(NSString *)teamId option:(NIMKitInfoFetchOption *)option
{
    NIMKitInfo *info = nil;
    if (self.provider && [self.provider respondsToSelector:@selector(infoByTeam:option:)]) {
        info = [self.provider infoByTeam:teamId option:option];
    }
    return info;

}

- (void)preloadNIMKitBundleResource {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NIMInputEmoticonManager sharedManager] preloadEmoticonResource];
    });
}
-(UIImage *)YUVtoUIImage:(int)w h:(int)h buffer:(unsigned char *)buffer{
    //YUV(NV12)-->CIImage--->UIImage Conversion
    NSDictionary *pixelAttributes = @{(NSString*)kCVPixelBufferIOSurfacePropertiesKey:@{}};
    
    
    CVPixelBufferRef pixelBuffer = NULL;
    
    CVReturn result = CVPixelBufferCreate(kCFAllocatorDefault,
                                          w,
                                          h,
                                          kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
                                          (__bridge CFDictionaryRef)(pixelAttributes),
                                          &pixelBuffer);
    
    CVPixelBufferLockBaseAddress(pixelBuffer,0);
    unsigned char *yDestPlane = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    
    // Here y_ch0 is Y-Plane of YUV(NV12) data.
    unsigned char *y_ch0 = buffer;
    unsigned char *y_ch1 = buffer + w * h;
    memcpy(yDestPlane, y_ch0, w * h);
    unsigned char *uvDestPlane = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
    
    // Here y_ch1 is UV-Plane of YUV(NV12) data.
    memcpy(uvDestPlane, y_ch1, w * h/2);
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    if (result != kCVReturnSuccess) {
        NSLog(@"Unable to create cvpixelbuffer %d", result);
    }
    
    // CIImage Conversion
    CIImage *coreImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    CIContext *MytemporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef MyvideoImage = [MytemporaryContext createCGImage:coreImage
                                                       fromRect:CGRectMake(0, 0, w, h)];
    
    // UIImage Conversion
    UIImage *Mynnnimage = [[UIImage alloc] initWithCGImage:MyvideoImage
                                                     scale:1.0
                                               orientation:UIImageOrientationRight];
    
    CVPixelBufferRelease(pixelBuffer);
    CGImageRelease(MyvideoImage);
    
    return Mynnnimage;
}
@end



