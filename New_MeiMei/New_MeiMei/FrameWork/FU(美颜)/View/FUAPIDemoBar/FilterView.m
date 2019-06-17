//
//  FilterView.m
//  FULiveDemoBar
//
//  Created by L on 2018/3/24.
//  Copyright © 2018年 L. All rights reserved.
//

#import "FilterView.h"
#import "UIImage+demobar.h"


@interface FilterView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation FilterView


-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.delegate = self ;
    self.dataSource = self;
    [self registerClass:[FilterViewCell class] forCellWithReuseIdentifier:@"FilterViewCell"];
}

-(void)setFilterDataSource:(NSArray<NSString *> *)filterDataSource {
    _filterDataSource = filterDataSource ;
    [self reloadData];
}

-(void)setSelectedFilterIndex:(NSInteger)selectedFilterIndex {
    _selectedFilterIndex = selectedFilterIndex ;
    [self reloadData];
}

-(void)setFiltersCHName:(NSDictionary<NSString *,NSString *> *)filtersCHName {
    _filtersCHName = filtersCHName ;
    [self reloadData];
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filterDataSource.count ;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FilterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterViewCell" forIndexPath:indexPath];
    
    NSString *imageName = self.filterDataSource[indexPath.row] ;
    
    cell.imageView.image = [UIImage imageWithName:imageName];
    
    NSString *filter = self.filterDataSource[indexPath.row];
    cell.titleLabel.text = _filtersCHName[filter] ? _filtersCHName[filter]:filter;
    cell.titleLabel.textColor = [UIColor whiteColor];
    
    cell.imageView.layer.borderWidth = 0.0 ;
    cell.imageView.layer.borderColor = [UIColor clearColor].CGColor;
    
    if (self.selectedFilterIndex == indexPath.row) {
        cell.imageView.layer.borderWidth = 2.0 ;
        cell.imageView.layer.borderColor = [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0].CGColor;
        cell.titleLabel.textColor = [UIColor colorWithRed:91 / 255.0 green:181 / 255.0 blue:249 / 255.0 alpha:1.0];
    }
    
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.selectedFilterIndex) {
        return ;
    }
    
    if (_selectedFilterIndex != -1) {
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(filterView:didHiddeFilter:)]) {
            [self.mDelegate filterView:self didHiddeFilter:self.filterDataSource[_selectedFilterIndex]];
        }
    }
    _selectedFilterIndex = indexPath.row ;
    [collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(filterView:didSelectedFilter:)]) {
            [self.mDelegate filterView:self didSelectedFilter:self.filterDataSource[indexPath.row]];
        }
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 74) ;
}

@end


@implementation FilterViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 60)/ 2.0, 0, 60, 60)];
        [self addSubview:self.imageView ];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, frame.size.width, frame.size.height - 60)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.titleLabel];
    }
    return self ;
}
@end
