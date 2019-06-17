//
//  NTESCustomAttachmentDecoder.m
//  NIM
//
//  Created by amao on 7/2/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "NTESCustomAttachmentDecoder.h"
#import "GiftAttachment.h"

@implementation NTESCustomAttachmentDecoder

-(id<NIMCustomAttachment>)decodeAttachment:(NSString *)content{
    GiftAttachment *attachment = [[GiftAttachment alloc] init];
    
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:nil];
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            attachment.url = dict[@"url"];
            attachment.giftId = dict[@"giftId"];
            attachment.buttonTitle = dict[@"buttonTitle"];
        }
    }
    return attachment;
}



@end
