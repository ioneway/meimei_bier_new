//
//  BeautySkinView.h
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoBarType.h"

@protocol BeautySkinViewDelegate <NSObject>

@optional

- (void)beautySkinViewDidSelectType:(NSInteger)typeIndex isShow:(BOOL)isShow isDown:(BOOL)isDown ;

- (void)beautyShapeViewDidSelectType:(NSInteger)typeIndex isShow:(BOOL)isShow isDown:(BOOL)isDown ;

@end


@interface BeautySkinView : UICollectionView

@property (nonatomic, assign) FUAPIDemoBarType demoBarType ;

@property (nonatomic, assign) BeautyViewType type ;

@property (nonatomic, assign) BOOL skinDetectEnable ;

@property (nonatomic, assign) BOOL clearBlur ;// 清晰磨皮0，朦胧1

@property (nonatomic, assign) NSInteger selectIndex ;

@property (nonatomic, assign) id<BeautySkinViewDelegate>mDelegate ;

@property (nonatomic, strong) NSMutableDictionary *beautySkinDict ;

@property (nonatomic, strong) NSMutableDictionary *beautyShapeDict ;

// isReload 表示 dataArray.count == 3 , NO 表示 dataArray.count == 7
- (void)reloadSectionInsects:(BOOL)isReload ;

@property (nonatomic, assign) NSInteger faceType ;
@end

@interface BeautySkinCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UIView *imageBgView ;
@property (nonatomic, strong) UILabel *titleLabel ;
@end
