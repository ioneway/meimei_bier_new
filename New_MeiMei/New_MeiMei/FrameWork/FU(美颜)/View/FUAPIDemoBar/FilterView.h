//
//  FilterView.h
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterView , FilterViewCell;

@protocol FilterViewDelegate <NSObject>

@optional
- (void)filterView:(FilterView *)filterView didSelectedFilter:(NSString *)filter;

- (void)filterView:(FilterView *)filterView didHiddeFilter:(NSString *)filter;

@end

@interface FilterView : UICollectionView

@property (nonatomic, strong) NSArray <NSString *>*filterDataSource ;

@property (nonatomic, assign) id<FilterViewDelegate>mDelegate ;

@property (nonatomic, assign) NSInteger selectedFilterIndex ;

@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *filtersCHName;

@end


@interface FilterViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UILabel *titleLabel ;
@end
