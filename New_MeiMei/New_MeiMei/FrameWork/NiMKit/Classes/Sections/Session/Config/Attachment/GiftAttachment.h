//
//  GiftAttachment.h
//  PengPengApp
//
//  Created by air on 2018/12/1.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftAttachment : NSObject<NIMCustomAttachment>

@property (nonatomic,copy)    NSString *url;

@property (nonatomic,copy)    NSString *giftId;

@property (nonatomic,copy)    NSString *buttonTitle;

@end

NS_ASSUME_NONNULL_END
