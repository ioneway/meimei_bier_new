//
//  FUItemsView.m
//  FUAPIDemoBar
//
//  Created by L on 2018/4/12.
//  Copyright © 2018年 L. All rights reserved.
//

#import "ItemsView.h"
#import "UIImage+demobar.h"

@interface ItemsView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger selectIndex ;
    BOOL bLoading;
}

@end

@implementation ItemsView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        selectIndex = -1 ;
        bLoading = NO ;
    }
    return self ;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
    self.delegate = self ;
    self.dataSource = self ;
    
    selectIndex = -1 ;
    bLoading = NO ;
    [self registerClass:[FUItemsCell class] forCellWithReuseIdentifier:@"FUItemsCell"];
}

-(void)setItemsArray:(NSArray *)itemsArray {
    _itemsArray = itemsArray ;
    [self reloadData];
}

-(void)setSelectedItem:(NSString *)selectedItem {
    _selectedItem = selectedItem ;
    
    selectIndex = [_itemsArray indexOfObject:selectedItem];
    
    [self reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count ;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FUItemsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FUItemsCell" forIndexPath:indexPath];
    
    cell.imageView.layer.borderWidth = 0.0 ;
    cell.imageView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.imageView.image = [UIImage imageWithName:self.itemsArray[indexPath.row]];
    
    if (indexPath.row == selectIndex) {
        cell.imageView.layer.borderWidth = 2.0 ;
        cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        if (bLoading) {
            [cell.indicator startAnimating];
        }
    }
    return cell ;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == selectIndex) {
        return ;
    }
    bLoading = YES;
    self.userInteractionEnabled = NO;
    selectIndex = indexPath.row;
    [collectionView reloadData];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([self.mDelegate respondsToSelector:@selector(itemsViewDidSelectItem:)]) {
            [self.mDelegate itemsViewDidSelectItem:self.itemsArray[indexPath.row]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            bLoading = NO;
            self.userInteractionEnabled = YES;
            FUItemsCell *cell = (FUItemsCell *)[collectionView cellForItemAtIndexPath:indexPath];
            [cell.indicator stopAnimating];
        });
    });
}


@end




@implementation FUItemsCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.layer.masksToBounds = YES ;
        self.imageView.layer.cornerRadius = frame.size.width / 2.0 ;
        self.imageView.layer.borderColor = [UIColor clearColor].CGColor;
        self.imageView.layer.borderWidth = 0.0 ;
        [self addSubview:self.imageView ];
        
        self.indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 37)/ 2.0, (self.bounds.size.width - 37)/ 2.0, 37, 37)];
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite ;
        self.indicator.hidesWhenStopped = YES ;
        [self.indicator stopAnimating ];
        [self addSubview:self.indicator ];
    }
    return self ;
}

@end
