//
//  NIMSessionGiftContentView.m
//  PengPengApp
//
//  Created by air on 2018/12/1.
//  Copyright © 2018年 陈政宏. All rights reserved.
//

#import "NIMSessionGiftContentView.h"
#import "NIMMessageModel.h"
#import "UIView+NIM.h"
#import "NIMLoadProgressView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GiftAttachment.h"
#import <SnapKit/SnapKit-Swift.h>

@interface NIMSessionGiftContentView()

@property (nonatomic,strong,readwrite) UIImageView * imageView;



@end
@implementation NIMSessionGiftContentView
{
    UIButton *gitButton;
}
- (instancetype)initSessionMessageContentView{
    self = [super initSessionMessageContentView];
    if (self) {
        self.opaque = YES;
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        _imageView.frame = CGRectMake(30, 10, 60, 60);
        gitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gitButton.frame = CGRectMake(25, 80, 70, 20);
        [gitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [gitButton setTitle:@"未知" forState:UIControlStateNormal];
        gitButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [gitButton setBackgroundImage:[UIImage imageNamed:@"icon_personal_lookback"] forState:UIControlStateNormal];
        gitButton.userInteractionEnabled = NO;
        [self addSubview:gitButton];
    }
    return self;
}

- (void)refresh:(NIMMessageModel *)data
{
    [super refresh:data];
    NIMCustomObject * object = (NIMCustomObject*)self.model.message.messageObject;
    GiftAttachment *atta = (GiftAttachment *)object.attachment;
    [gitButton setTitle:atta.buttonTitle forState:UIControlStateNormal];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:atta.url]];

}

- (void)layoutSubviews{
    [super layoutSubviews];

}


- (void)onTouchUpInside:(id)sender
{
    NIMKitEvent *event = [[NIMKitEvent alloc] init];
    event.eventName = NIMKitEventNameTapContent;
    event.messageModel = self.model;
    [self.delegate onCatchEvent:event];
}



@end
