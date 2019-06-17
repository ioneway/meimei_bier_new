//
//  FUItemsView.h
//  FUAPIDemoBar
//
//  Created by L on 2018/4/12.
//  Copyright © 2018年 L. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FUItemsViewDelegate <NSObject>

- (void)itemsViewDidSelectItem:(NSString *)itemName ;
@end

@interface ItemsView : UICollectionView

@property (nonatomic, strong) NSArray *itemsArray ;
@property (nonatomic, copy)   NSString *selectedItem ;

@property (nonatomic, assign) id<FUItemsViewDelegate>mDelegate ;
@end

@interface FUItemsCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView ;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end
