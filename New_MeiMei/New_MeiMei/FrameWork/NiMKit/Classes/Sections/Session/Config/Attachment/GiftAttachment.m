//
//  GiftAttachment.m
//  PengPengApp
//
//  Created by air on 2018/12/1.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

#import "GiftAttachment.h"

@implementation GiftAttachment

- (nonnull NSString *)encodeAttachment {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:_url forKey:@"url"];
    [dict setObject:_giftId forKey:@"giftId"];
    [dict setObject:_buttonTitle forKey:@"buttonTitle"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:nil];
    
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
    
}
- (NSString *)cellContent:(NIMMessage *)message
{
    return @"NIMSessionGiftContentView";
}

@end
